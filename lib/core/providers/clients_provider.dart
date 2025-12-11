import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart';
import '../database/app_database.dart';
import '../services/sync_service.dart';
import 'database_provider.dart';

// Provider to watch all clients
final clientsProvider = StreamProvider<List<Client>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.clients).watch();
});

// Provider to watch a single client
final clientProvider = StreamProvider.family<Client, int>((ref, id) {
  final db = ref.watch(appDatabaseProvider);
  return db
      .select(db.clients)
      .watch()
      .map((clients) => clients.firstWhere((c) => c.id == id));
});

// Provider to filter clients
final filteredClientsProvider =
    Provider.family<AsyncValue<List<Client>>, ClientFilter>((ref, filter) {
      final clientsAsync = ref.watch(clientsProvider);

      return clientsAsync.whenData((clients) {
        var filtered = clients;

        // Filter by query
        if (filter.query.isNotEmpty) {
          filtered = filtered
              .where(
                (c) =>
                    c.name.toLowerCase().contains(filter.query.toLowerCase()) ||
                    (c.address?.toLowerCase().contains(
                          filter.query.toLowerCase(),
                        ) ??
                        false),
              )
              .toList();
        }

        // Filter by category (formerly classification)
        if (filter.category != 'الكل') {
          filtered = filtered
              .where((c) => c.category == filter.category)
              .toList();
        }

        return filtered;
      });
    });

class ClientFilter {
  final String query;
  final String category;

  ClientFilter({this.query = '', this.category = 'الكل'});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ClientFilter &&
          runtimeType == other.runtimeType &&
          query == other.query &&
          category == other.category;

  @override
  int get hashCode => query.hashCode ^ category.hashCode;
}

// Controller for client operations
class ClientController extends Notifier<AsyncValue<void>> {
  late final AppDatabase _db;
  late final SyncService _syncService;

  @override
  AsyncValue<void> build() {
    _db = ref.watch(appDatabaseProvider);
    _syncService = ref.watch(syncServiceProvider);
    return const AsyncValue.data(null);
  }

  Future<void> addClient(ClientsCompanion client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // 1. Insert into local DB
      final id = await _db.insertClient(client);

      // 2. Queue for sync
      // We need to convert Companion to JSON-able map.
      // This is a bit manual with Drift Companions.
      final data = {
        'id': id, // Local ID
        'name': client.name.value,
        'phone': client.phone.value, // Will be List<String>
        'email': client.email.value,
        'category': client.category.value,
        'province': client.province.value,
        'district': client.district.value,
        'address': client.address.value,
        'gps_location': client.gpsLocation.value,
        'importance': client.importance.value,
        'is_agent': client.isAgent.value,
        'loyalty_level': client.loyaltyLevel.value,
        'notes': client.notes.value,
        'images': client.images.value,
        'profile_image': client.profileImage.value,
        'last_visit': client.lastVisit.value?.toIso8601String(),
      };

      await _syncService.queueOperation('clients', 'insert', data);
    });
  }

  Future<void> updateClient(ClientsCompanion client) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // 1. Update local DB
      await _db.updateClient(client);

      // 2. Queue for sync
      // Convert Companion to JSON
      final data = {
        'id': client.id.value,
        'name': client.name.value,
        'phone': client.phone.value,
        'email': client.email.value,
        'category': client.category.value,
        'province': client.province.value,
        'district': client.district.value,
        'address': client.address.value,
        'gps_location': client.gpsLocation.value,
        'importance': client.importance.value,
        'is_agent': client.isAgent.value,
        'loyalty_level': client.loyaltyLevel.value,
        'notes': client.notes.value,
        'images': client.images.value,
        'profile_image': client.profileImage.value,
        'last_visit': client.lastVisit.value?.toIso8601String(),
      };

      await _syncService.queueOperation('clients', 'update', data);
    });
  }

  Future<void> deleteClient(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _db.deleteClient(id);

      await _syncService.queueOperation('clients', 'delete', {'id': id});
    });
  }
}

final clientControllerProvider =
    NotifierProvider<ClientController, AsyncValue<void>>(ClientController.new);

// --- Client Employees Providers ---

final clientEmployeesProvider =
    StreamProvider.family<List<ClientEmployee>, int>((ref, clientId) {
      final db = ref.watch(appDatabaseProvider);
      return (db.select(
        db.clientEmployees,
      )..where((e) => e.clientId.equals(clientId))).watch();
    });

class EmployeeWithClient {
  final ClientEmployee employee;
  final Client? client;
  final Client? previousClient;

  EmployeeWithClient({
    required this.employee,
    this.client,
    this.previousClient,
  });
}

final allEmployeesProvider = StreamProvider<List<EmployeeWithClient>>((ref) {
  final db = ref.watch(appDatabaseProvider);
  return db.select(db.clientEmployees).watch().asyncMap((employees) async {
    final clients = await db.select(db.clients).get();
    return employees.map((employee) {
      final client = clients.cast<Client?>().firstWhere(
        (c) => c?.id == employee.clientId,
        orElse: () => null,
      );
      final previousClient = clients.cast<Client?>().firstWhere(
        (c) => c?.id == employee.previousClientId,
        orElse: () => null,
      );
      return EmployeeWithClient(
        employee: employee,
        client: client,
        previousClient: previousClient,
      );
    }).toList();
  });
});

class ClientEmployeesController extends Notifier<AsyncValue<void>> {
  late final AppDatabase _db;
  late final SyncService _syncService;

  @override
  AsyncValue<void> build() {
    _db = ref.watch(appDatabaseProvider);
    _syncService = ref.watch(syncServiceProvider);
    return const AsyncValue.data(null);
  }

  Future<void> addEmployee(ClientEmployeesCompanion employee) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      final id = await _db.insertClientEmployee(employee);

      // Queue for sync
      final data = {
        'id': id,
        'client_id': employee.clientId.value,
        'name': employee.name.value,
        'phone': employee.phone.value,
        'role': employee.role.value,
        'is_decision_maker': employee.isDecisionMaker.value,
        'notes': employee.notes.value,
      };

      await _syncService.queueOperation('client_employees', 'insert', data);
    });
  }

  Future<void> updateEmployee(ClientEmployeesCompanion employee) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      // Fetch existing to check for client change
      final existing = await (_db.select(
        _db.clientEmployees,
      )..where((e) => e.id.equals(employee.id.value))).getSingle();

      var finalEmployee = employee;

      if (employee.clientId.present &&
          employee.clientId.value != existing.clientId) {
        // Client changed, update previousClientId
        finalEmployee = employee.copyWith(
          previousClientId: Value(existing.clientId),
        );
      }

      await (_db.update(
        _db.clientEmployees,
      )..where((e) => e.id.equals(employee.id.value))).write(finalEmployee);

      // Queue for sync
      final data = {
        'id': employee.id.value,
        'client_id': employee.clientId.value,
        'name': employee.name.value,
        'phone': employee.phone.value,
        'role': employee.role.value,
        'is_decision_maker': employee.isDecisionMaker.value,
        'notes': employee.notes.value,
      };

      await _syncService.queueOperation('client_employees', 'update', data);
    });
  }

  Future<void> deleteEmployee(int id) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await (_db.delete(
        _db.clientEmployees,
      )..where((e) => e.id.equals(id))).go();

      await _syncService.queueOperation('client_employees', 'delete', {
        'id': id,
      });
    });
  }
}

final clientEmployeesControllerProvider =
    NotifierProvider<ClientEmployeesController, AsyncValue<void>>(
      ClientEmployeesController.new,
    );
