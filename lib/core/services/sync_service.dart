import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:drift/drift.dart' as drift;
import 'package:drift/drift.dart'; // For OrderingTerm
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import '../database/app_database.dart';
import '../providers/database_provider.dart';
import '../constants/api_constants.dart';
import 'auth_service.dart';

final syncServiceProvider = Provider<SyncService>((ref) {
  return SyncService(
    ref.watch(appDatabaseProvider),
    ref.watch(authServiceProvider),
  );
});

class SyncService {
  final AppDatabase _db;
  final AuthService _authService;

  static const String _baseUrl = ApiConstants.baseUrl;

  Timer? _timer;
  bool _isSyncing = false;
  bool _autoSyncEnabled = true;

  SyncService(this._db, this._authService) {
    _startSyncTimer();
  }

  void _startSyncTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(minutes: 1), (timer) {
      if (_autoSyncEnabled) {
        syncPendingItems();
      }
    });
  }

  void enableAutoSync() {
    _autoSyncEnabled = true;
  }

  void disableAutoSync() {
    _autoSyncEnabled = false;
  }

  bool get isAutoSyncEnabled => _autoSyncEnabled;

  Future<void> syncPendingItems() async {
    if (_isSyncing) return;
    _isSyncing = true;

    try {
      // Get pending items from SyncQueue
      final pendingItems =
          await (_db.select(_db.syncQueue)
                ..where((tbl) => tbl.status.equals('pending'))
                ..orderBy([(t) => OrderingTerm.asc(t.createdAt)]))
              .get();

      for (final item in pendingItems) {
        bool success = false;
        try {
          success = await _processSyncItem(item);
        } catch (e) {
          print('Error processing sync item ${item.id}: $e');
        }

        if (success) {
          // Mark as completed or delete
          await (_db.delete(
            _db.syncQueue,
          )..where((t) => t.id.equals(item.id))).go();
        } else {
          // Increment retry count or mark as failed
          await (_db.update(
            _db.syncQueue,
          )..where((t) => t.id.equals(item.id))).write(
            SyncQueueCompanion(
              retryCount: drift.Value(item.retryCount + 1),
              // status: drift.Value('failed'), // Optionally mark as failed after N retries
            ),
          );
        }
      }
    } finally {
      _isSyncing = false;
    }
  }

  Future<bool> _processSyncItem(SyncQueueData item) async {
    print(
      'Processing sync item: ${item.entity} - ${item.operation} (ID: ${item.id})',
    );
    final token = await _authService.getToken();
    if (token == null) {
      print('Sync skipped: No auth token');
      return false;
    }

    final url = Uri.parse('$_baseUrl/${item.entity}');
    final headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };

    http.Response response;

    switch (item.operation) {
      case 'insert':
        // Handle file uploads before sending payload
        var payloadMap = jsonDecode(item.payload ?? '{}');
        payloadMap = await _handleFileUploads(payloadMap, item.entity);
        final processedPayload = jsonEncode(payloadMap);

        response = await http.post(
          url,
          headers: headers,
          body: processedPayload,
        );
        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Success! Parse ID and update local record
          print('Insert success: ${response.body}');
          try {
            final responseData = jsonDecode(response.body);
            // Try multiple paths for ID
            var remoteId = responseData['data']?['id'];
            if (remoteId == null && responseData['data'] is Map) {
              // Check if it's nested under entity name (e.g. data['client']['id'])
              final entityData =
                  responseData['data'][item.entity.substring(
                    0,
                    item.entity.length - 1,
                  )]; // client from clients
              if (entityData != null && entityData is Map) {
                remoteId = entityData['id'];
              }
            }
            if (remoteId == null) {
              remoteId = responseData['id']; // Check root
            }
            final payloadMap = jsonDecode(item.payload ?? '{}');
            final localId = payloadMap['id'];

            if (remoteId != null && localId != null) {
              await _updateLocalRemoteId(item.entity, localId, remoteId);
              // Update local paths with server paths (from payloadMap)
              await _updateLocalPaths(item.entity, localId, payloadMap);
            } else {
              print(
                'Insert warning: remoteId ($remoteId) or localId ($localId) is null',
              );
            }
          } catch (e) {
            print('Error updating remote ID: $e');
          }
        } else {
          print('Insert failed: ${response.statusCode} - ${response.body}');
        }
        break;
      case 'update':
        // Handle file uploads for update as well
        var payloadMap = jsonDecode(item.payload ?? '{}');
        payloadMap = await _handleFileUploads(payloadMap, item.entity);
        final processedPayload = jsonEncode(payloadMap);

        final localId = payloadMap['id'];

        // We need the remote ID for the URL
        int? remoteId = await _getRemoteId(item.entity, localId);

        if (remoteId == null) {
          print(
            'Sync Error: No remote ID found for update (Local ID: $localId, Entity: ${item.entity})',
          );
          return false;
        }

        final updateUrl = Uri.parse('$_baseUrl/${item.entity}/$remoteId');
        response = await http.put(
          updateUrl,
          headers: headers,
          body: processedPayload,
        );

        if (response.statusCode >= 200 && response.statusCode < 300) {
          // Update local paths with server paths
          await _updateLocalPaths(item.entity, localId, payloadMap);
        }
        break;
      case 'delete':
        final payloadMap = jsonDecode(item.payload ?? '{}');
        final localId = payloadMap['id'];

        int? remoteId = await _getRemoteId(item.entity, localId);

        if (remoteId == null) {
          print(
            'Sync Error: No remote ID found for delete (Local ID: $localId)',
          );
          return true;
        }

        final deleteUrl = Uri.parse('$_baseUrl/${item.entity}/$remoteId');
        response = await http.delete(deleteUrl, headers: headers);
        break;
      default:
        print('Sync Error: Unknown operation ${item.operation}');
        return false;
    }

    print(
      'Sync Response (${item.operation} ${item.entity}): ${response.statusCode}',
    );
    if (response.statusCode >= 300) {
      print('Sync Error Body: ${response.body}');
      throw Exception('Sync failed: ${response.statusCode} - ${response.body}');
    }

    return response.statusCode >= 200 && response.statusCode < 300;
  }

  Future<void> _updateLocalRemoteId(
    String entity,
    int localId,
    int remoteId,
  ) async {
    switch (entity) {
      case 'clients':
        await (_db.update(_db.clients)..where((t) => t.id.equals(localId)))
            .write(ClientsCompanion(remoteId: drift.Value(remoteId)));
        break;
      case 'client_employees':
        await (_db.update(_db.clientEmployees)
              ..where((t) => t.id.equals(localId)))
            .write(ClientEmployeesCompanion(remoteId: drift.Value(remoteId)));
        break;
      case 'branches':
        await (_db.update(_db.branches)..where((t) => t.id.equals(localId)))
            .write(BranchesCompanion(remoteId: drift.Value(remoteId)));
        break;
    }
  }

  Future<int?> _getRemoteId(String entity, int localId) async {
    switch (entity) {
      case 'clients':
        final item = await (_db.select(
          _db.clients,
        )..where((t) => t.id.equals(localId))).getSingleOrNull();
        return item?.remoteId;
      case 'client_employees':
        final item = await (_db.select(
          _db.clientEmployees,
        )..where((t) => t.id.equals(localId))).getSingleOrNull();
        return item?.remoteId;
      case 'branches':
        final item = await (_db.select(
          _db.branches,
        )..where((t) => t.id.equals(localId))).getSingleOrNull();
        return item?.remoteId;
    }
    return null;
  }

  // Helper to queue an item
  Future<void> queueOperation(
    String entity,
    String operation,
    Map<String, dynamic> data,
  ) async {
    await _db
        .into(_db.syncQueue)
        .insert(
          SyncQueueCompanion.insert(
            id: DateTime.now().millisecondsSinceEpoch
                .toString(), // Simple ID generation
            entity: entity,
            operation: operation,
            payload: drift.Value(jsonEncode(data)),
            status: drift.Value('pending'),
          ),
        );

    // Trigger sync immediately if auto-sync is on
    if (_autoSyncEnabled) {
      syncPendingItems();
    }
  }

  Future<void> syncAll() async {
    await pullClients();
    await pullBranches();
    await pullCities();
    await pullClassifications();
    await pullClientEmployees();
    await pullTasks();
    await pullCampaigns();
    await pullFieldReports();
    await syncPendingItems();
  }

  // Pull clients from server
  Future<void> pullClients() async {
    await _pullEntity('clients', (item) async {
      final remoteId = int.tryParse(item['id'].toString());
      if (remoteId == null) return;

      final existing = await (_db.select(
        _db.clients,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

      final companion = ClientsCompanion(
        remoteId: drift.Value(remoteId),
        name: drift.Value(item['name'] ?? ''),
        phone: drift.Value(_parsePhone(item['phone'])),
        email: drift.Value(item['email']),
        category: drift.Value(item['category']),
        province: drift.Value(item['province']),
        district: drift.Value(item['district']),
        address: drift.Value(item['address']),
        gpsLocation: drift.Value(item['gps_location']),
        importance: drift.Value(item['importance']),
        isAgent: drift.Value(item['is_agent'] == 1 || item['is_agent'] == true),
        loyaltyLevel: drift.Value(item['loyalty_level']),
        notes: drift.Value(item['notes']),
        profileImage: drift.Value(item['profile_image']),
        images: drift.Value(
          item['images'] is List
              ? (item['images'] as List).cast<String>()
              : (item['images'] != null
                    ? List<String>.from(jsonDecode(item['images']))
                    : []),
        ),
      );

      if (existing != null) {
        await (_db.update(
          _db.clients,
        )..where((t) => t.remoteId.equals(remoteId))).write(companion);
      } else {
        await _db.into(_db.clients).insert(companion);
      }
    });
  }

  Future<void> pullFieldReports() async {
    await _pullEntity('field_reports', (item) async {
      final id = item['id']?.toString();
      if (id == null) return;

      final existing = await (_db.select(
        _db.fieldReports,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      final companion = FieldReportsCompanion(
        id: drift.Value(id),
        notes: drift.Value(item['notes']),
        location: drift.Value(item['location']),
        taskId: drift.Value(item['task_id']?.toString()),
        reporterId: drift.Value(
          int.tryParse(item['reporter_id']?.toString() ?? ''),
        ),
        photos: drift.Value(
          item['photos'] is List
              ? (item['photos'] as List).cast<String>()
              : (item['photos'] != null
                    ? List<String>.from(jsonDecode(item['photos']))
                    : []),
        ),
        syncStatus: const drift.Value('synced'),
      );

      if (existing != null) {
        await (_db.update(
          _db.fieldReports,
        )..where((t) => t.id.equals(id))).write(companion);
      } else {
        await _db.into(_db.fieldReports).insert(companion);
      }
    });
  }

  Future<void> pullTasks() async {
    await _pullEntity('tasks', (item) async {
      final id = item['id']?.toString(); // UUID should be string
      if (id == null) return;

      final existing = await (_db.select(
        _db.tasks,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      final companion = TasksCompanion(
        id: drift.Value(id),
        title: drift.Value(item['title'] ?? ''),
        description: drift.Value(item['description']),
        status: drift.Value(item['status'] ?? 'todo'),
        priority: drift.Value(item['priority'] ?? 'medium'),
        startAt: drift.Value(
          item['start_at'] != null ? DateTime.parse(item['start_at']) : null,
        ),
        dueAt: drift.Value(
          item['due_at'] != null ? DateTime.parse(item['due_at']) : null,
        ),
        location: drift.Value(item['location']),
        progressPercentage: drift.Value(
          int.tryParse(item['progress_percentage']?.toString() ?? '0') ?? 0,
        ),
        campaignId: drift.Value(
          int.tryParse(item['campaign_id']?.toString() ?? ''),
        ),
        clientId: drift.Value(
          int.tryParse(item['client_id']?.toString() ?? ''),
        ),
        assigneeId: drift.Value(
          int.tryParse(item['assignee_id']?.toString() ?? ''),
        ),
        syncStatus: const drift.Value('synced'),
      );

      if (existing != null) {
        await (_db.update(
          _db.tasks,
        )..where((t) => t.id.equals(id))).write(companion);
      } else {
        await _db.into(_db.tasks).insert(companion);
      }
    });
  }

  Future<void> pullCampaigns() async {
    await _pullEntity('campaigns', (item) async {
      final id = int.tryParse(item['id'].toString());
      if (id == null) return;

      final existing = await (_db.select(
        _db.campaigns,
      )..where((t) => t.id.equals(id))).getSingleOrNull();

      final companion = CampaignsCompanion(
        id: drift.Value(id),
        title: drift.Value(item['title'] ?? ''),
        description: drift.Value(item['description']),
        campaignType: drift.Value(item['campaign_type'] ?? 'general'),
        status: drift.Value(item['status'] ?? 'draft'),
        startDate: drift.Value(
          item['start_date'] != null
              ? DateTime.parse(item['start_date'])
              : null,
        ),
        endDate: drift.Value(
          item['end_date'] != null ? DateTime.parse(item['end_date']) : null,
        ),
        objective: drift.Value(item['objective']),
        budget: drift.Value(
          item['budget'] != null
              ? double.tryParse(item['budget'].toString()) ?? 0.0
              : 0.0,
        ),
      );

      if (existing != null) {
        await (_db.update(
          _db.campaigns,
        )..where((t) => t.id.equals(id))).write(companion);
      } else {
        await _db.into(_db.campaigns).insert(companion);
      }
    });
  }

  Future<void> pullBranches() async {
    await _pullEntity('branches', (item) async {
      final remoteId = int.tryParse(item['id'].toString());
      if (remoteId == null) return;

      final existing = await (_db.select(
        _db.branches,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

      final companion = BranchesCompanion(
        remoteId: drift.Value(remoteId),
        name: drift.Value(item['name'] ?? ''),
        address: drift.Value(item['address']),
        phone: drift.Value(item['phone']),
        managerName: drift.Value(item['manager_name']),
      );

      if (existing != null) {
        await (_db.update(
          _db.branches,
        )..where((t) => t.remoteId.equals(remoteId))).write(companion);
      } else {
        await _db.into(_db.branches).insert(companion);
      }
    });
  }

  Future<void> pullCities() async {
    await _pullEntity('cities', (item) async {
      final remoteId = int.tryParse(item['id'].toString());
      if (remoteId == null) return;

      final existing = await (_db.select(
        _db.cities,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

      final companion = CitiesCompanion(
        remoteId: drift.Value(remoteId),
        name: drift.Value(item['name'] ?? ''),
        governorate: drift.Value(item['governorate']),
      );

      if (existing != null) {
        await (_db.update(
          _db.cities,
        )..where((t) => t.remoteId.equals(remoteId))).write(companion);
      } else {
        await _db.into(_db.cities).insert(companion);
      }
    });
  }

  Future<void> pullClassifications() async {
    await _pullEntity('classifications', (item) async {
      final remoteId = int.tryParse(item['id'].toString());
      if (remoteId == null) return;

      final existing = await (_db.select(
        _db.classifications,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

      final companion = ClassificationsCompanion(
        remoteId: drift.Value(remoteId),
        name: drift.Value(item['name'] ?? ''),
        type: drift.Value(item['type']),
      );

      if (existing != null) {
        await (_db.update(
          _db.classifications,
        )..where((t) => t.remoteId.equals(remoteId))).write(companion);
      } else {
        await _db.into(_db.classifications).insert(companion);
      }
    });
  }

  Future<void> pullClientEmployees() async {
    await _pullEntity('client_employees', (item) async {
      final remoteId = int.tryParse(item['id'].toString());
      if (remoteId == null) return;

      final existing = await (_db.select(
        _db.clientEmployees,
      )..where((t) => t.remoteId.equals(remoteId))).getSingleOrNull();

      final companion = ClientEmployeesCompanion(
        remoteId: drift.Value(remoteId),
        clientId: drift.Value(
          int.tryParse(item['client_id']?.toString() ?? '0') ?? 0,
        ), // Ensure client_id is handled
        name: drift.Value(item['name'] ?? ''),
        phone: drift.Value(
          item['phone'] is List
              ? (item['phone'] as List).join(', ')
              : item['phone']?.toString(),
        ),
        role: drift.Value(item['role']),
        isDecisionMaker: drift.Value(
          item['is_decision_maker'] == 1 || item['is_decision_maker'] == true,
        ),
        notes: drift.Value(item['notes']),
      );

      if (existing != null) {
        await (_db.update(
          _db.clientEmployees,
        )..where((t) => t.remoteId.equals(remoteId))).write(companion);
      } else {
        await _db.into(_db.clientEmployees).insert(companion);
      }
    });
  }

  Future<void> _pullEntity(
    String entity,
    Future<void> Function(Map<String, dynamic>) upsert,
  ) async {
    try {
      final token = await _authService.getToken();
      if (token == null) {
        print('Pull $entity skipped: No auth token');
        return;
      }

      final url = Uri.parse(
        '$_baseUrl/sync/pull',
      ); // Use the generic pull endpoint
      final response = await http.get(
        url.replace(
          queryParameters: {'entities[]': entity},
        ), // Pass entity as array
        headers: {
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final List<dynamic> data = responseData['data'][entity] ?? [];

        for (final item in data) {
          await upsert(item);
        }
        print('Pull $entity successful: ${data.length} items synced.');
      } else {
        print('Pull $entity failed: ${response.statusCode}');
        print('Response length: ${response.body.length}');
        if (response.body.length > 100) {
          print('Response start: ${response.body.substring(0, 100)}');
          print(
            'Response end: ${response.body.substring(response.body.length - 100)}',
          );
        } else {
          print('Response body: ${response.body}');
        }
      }
    } catch (e) {
      print('Pull $entity error: $e');
    }
  }

  Future<Map<String, dynamic>> _handleFileUploads(
    Map<String, dynamic> payload,
    String entity,
  ) async {
    final newPayload = Map<String, dynamic>.from(payload);

    // Determine base naming components
    String safeName = 'unknown';
    String date = DateTime.now().toIso8601String().split('T')[0];

    if (entity == 'clients') {
      final name = payload['name']?.toString() ?? 'unknown';
      // Sanitize name: remove everything except a-z, A-Z, 0-9, and _
      safeName = name
          .replaceAll(
            RegExp(r'[^\w\s]'),
            '',
          ) // Remove non-word chars (removes Arabic)
          .trim()
          .replaceAll(RegExp(r'\s+'), '_');

      // If name became empty (e.g. was all Arabic), use a generic name with timestamp
      if (safeName.isEmpty) {
        safeName = 'client_${DateTime.now().millisecondsSinceEpoch}';
      }
    } else if (entity == 'field_reports') {
      safeName = 'report_${payload['id'] ?? 'new'}';
    }

    // Check profile_image (Clients)
    if (newPayload.containsKey('profile_image') &&
        newPayload['profile_image'] != null) {
      final path = newPayload['profile_image'] as String;
      if (path.isNotEmpty &&
          !path.startsWith('http') &&
          File(path).existsSync()) {
        final ext = path.split('.').last;
        final filename = '${safeName}_${date}_profile.$ext';
        // Align with Filament: clients/profiles/{date}_{name}
        final folder = 'clients/profiles/${date}_$safeName';
        print('Uploading profile to: $folder');

        final serverPath = await _uploadFile(path, folder, filename);
        if (serverPath != null) {
          newPayload['profile_image'] = serverPath;
        }
      }
    }

    // Check images list (Clients)
    if (newPayload.containsKey('images') && newPayload['images'] != null) {
      final images = newPayload['images'];
      if (images is List) {
        final newImages = <String>[];
        int index = 1;
        for (final img in images) {
          final path = img as String;
          if (path.isNotEmpty &&
              !path.startsWith('http') &&
              File(path).existsSync()) {
            final ext = path.split('.').last;
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final filename =
                '${safeName}_${date}_gallery_${timestamp}_$index.$ext';
            // Align with Filament: clients/galleries/{date}_{name}
            final folder = 'clients/galleries/${date}_$safeName';

            final serverPath = await _uploadFile(path, folder, filename);
            if (serverPath != null) {
              newImages.add(serverPath);
            } else {
              newImages.add(path); // Keep original if upload fails?
            }
            index++;
          } else {
            newImages.add(path);
          }
        }
        newPayload['images'] = newImages;
      }
    }

    // Check photos list (Field Reports)
    if (newPayload.containsKey('photos') && newPayload['photos'] != null) {
      final photos = newPayload['photos'];
      if (photos is List) {
        final newPhotos = <String>[];
        int index = 1;
        for (final img in photos) {
          final path = img as String;
          if (path.isNotEmpty &&
              !path.startsWith('http') &&
              File(path).existsSync()) {
            final ext = path.split('.').last;
            final timestamp = DateTime.now().millisecondsSinceEpoch;
            final filename =
                '${safeName}_${date}_photo_${timestamp}_$index.$ext';
            final folder = 'field_reports/${date}_$safeName';

            final serverPath = await _uploadFile(path, folder, filename);
            if (serverPath != null) {
              newPhotos.add(serverPath);
            } else {
              newPhotos.add(path);
            }
            index++;
          } else {
            newPhotos.add(path);
          }
        }
        newPayload['photos'] = newPhotos;
      }
    }

    return newPayload;
  }

  Future<String?> _uploadFile(
    String localPath,
    String folder, [
    String? filename,
  ]) async {
    try {
      final token = await _authService.getToken();
      if (token == null) return null;

      final uri = Uri.parse('$_baseUrl/upload');
      final request = http.MultipartRequest('POST', uri);
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Accept'] = 'application/json';

      request.files.add(await http.MultipartFile.fromPath('file', localPath));
      request.fields['folder'] = folder;
      if (filename != null) {
        request.fields['filename'] = filename;
      }

      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        print('Upload successful: ${data['path']}');
        return data['path']; // Server returns relative path
      } else {
        print('Upload failed: ${response.statusCode} - ${response.body}');
        return null;
      }
    } catch (e) {
      print('Upload error: $e');
      return null;
    }
  }

  Future<void> _updateLocalPaths(
    String entity,
    int localId,
    Map<String, dynamic> payload,
  ) async {
    if (entity != 'clients') return; // Only clients have images for now

    final companion = ClientsCompanion(
      profileImage: payload.containsKey('profile_image')
          ? drift.Value(payload['profile_image'])
          : const drift.Value.absent(),
      images: payload.containsKey('images')
          ? drift.Value((payload['images'] as List).cast<String>())
          : const drift.Value.absent(),
    );

    await (_db.update(
      _db.clients,
    )..where((t) => t.id.equals(localId))).write(companion);
  }

  List<String>? _parsePhone(dynamic rawPhone) {
    if (rawPhone == null) return null;

    if (rawPhone is List) {
      return rawPhone.map((e) => e.toString()).toList();
    }

    if (rawPhone is String) {
      String p = rawPhone.trim();

      // Attempt to decode JSON recursively
      if (p.startsWith('[') || p.startsWith('"')) {
        try {
          final decoded = jsonDecode(p);
          return _parsePhone(decoded);
        } catch (_) {
          // Decoding failed, treat as raw string
        }
      }

      // Clean up artifacts like `["` or `"]` or `\`
      // Remove backslashes, brackets, quotes
      p = p.replaceAll(RegExp(r'[\\\[\]"]'), '');

      if (p.isEmpty) return [];
      return [p];
    }

    return [rawPhone.toString()];
  }
}
