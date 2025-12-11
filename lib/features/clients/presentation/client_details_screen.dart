import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/api_constants.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import '../../../core/widgets/image_viewer_screen.dart';
import '../../../core/widgets/phone_selector_dialog.dart';
import '../../../core/extensions/client_extensions.dart';
import '../../customers/presentation/customer_form_screen.dart';

import 'client_employees_screen.dart';

class ClientDetailsScreen extends ConsumerWidget {
  final int clientId;

  const ClientDetailsScreen({super.key, required this.clientId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final clientsAsync = ref.watch(clientsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: clientsAsync.when(
        data: (clients) {
          final client = clients.where((c) => c.id == clientId).firstOrNull;

          if (client == null) {
            return const Center(child: Text('العميل غير موجود'));
          }

          debugPrint(
            'DEBUG: ClientDetailsScreen build - Client: ${client.name}, ProfileImage: ${client.profileImage}',
          );

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(context, ref, client),
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                sliver: SliverList(
                  delegate: SliverChildListDelegate([
                    _buildAnimatedItem(
                      0,
                      _buildContactSection(context, client),
                    ),
                    _buildAnimatedItem(
                      1,
                      _buildEmployeesSection(context, client),
                    ),
                    if (client.gpsLocation != null)
                      _buildAnimatedItem(
                        2,
                        _buildLocationSection(context, client),
                      ),
                    _buildAnimatedItem(
                      3,
                      _buildVisitInfoSection(context, client),
                    ),
                    if (client.images != null && client.images!.isNotEmpty)
                      _buildAnimatedItem(
                        4,
                        _buildImagesSection(context, client),
                      ),
                    _buildAnimatedItem(5, _buildDebugSection(context, client)),
                  ]),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('خطأ: $error')),
      ),
      floatingActionButton: _buildFab(context, ref),
    );
  }

  Widget _buildAnimatedItem(int index, Widget child) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 500),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Interval(
        (index * 0.1).clamp(0.0, 1.0),
        1.0,
        curve: Curves.easeOutQuart,
      ),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Padding(padding: const EdgeInsets.only(bottom: 16), child: child),
    );
  }

  Widget _buildSliverAppBar(
    BuildContext context,
    WidgetRef ref,
    Client client,
  ) {
    // 48-hour edit rule
    final canEdit = DateTime.now().difference(client.createdAt).inHours <= 48;

    return SliverAppBar(
      expandedHeight: 320.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.jabaliBlue,
      stretch: true,
      actions: [
        if (canEdit)
          Container(
            margin: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.edit, color: Colors.white),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CustomerFormScreen(
                      clientType: client.isAgent ? 'agent' : 'client',
                      clientId: client.id,
                      clientToEdit: client.toCompanion(true),
                    ),
                  ),
                );
              },
            ),
          ),
        Container(
          margin: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.black.withValues(alpha: 0.2),
            shape: BoxShape.circle,
          ),
          child: IconButton(
            icon: const Icon(Icons.delete, color: Colors.white),
            onPressed: () => _showDeleteDialog(context, ref),
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [
          StretchMode.zoomBackground,
          StretchMode.blurBackground,
        ],
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Background Image or Gradient
            client.profileImage != null
                ? Image(
                    image: _getImageProvider(client.profileImage!),
                    fit: BoxFit.cover,
                  )
                : Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topRight,
                        end: Alignment.bottomLeft,
                        colors: [AppColors.jabaliBlue, Color(0xFF1A237E)],
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -50,
                          top: -50,
                          child: Icon(
                            Icons.circle,
                            size: 300,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                        Positioned(
                          left: -30,
                          bottom: -30,
                          child: Icon(
                            Icons.circle,
                            size: 200,
                            color: Colors.white.withValues(alpha: 0.05),
                          ),
                        ),
                      ],
                    ),
                  ),

            // Gradient Overlay for readability
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black.withValues(alpha: 0.7),
                  ],
                ),
              ),
            ),

            // Content
            Positioned(
              bottom: 20,
              left: 20,
              right: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Profile Image with Glassmorphism
                  Row(
                    children: [
                      Hero(
                        tag: 'client_card_${client.id}',
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.2),
                            shape: BoxShape.circle,
                            border: Border.all(
                              color: Colors.white.withValues(alpha: 0.5),
                              width: 1,
                            ),
                          ),
                          child: CircleAvatar(
                            radius: 40,
                            backgroundColor: Colors.white.withValues(
                              alpha: 0.9,
                            ),
                            backgroundImage: client.profileImage != null
                                ? _getImageProvider(client.profileImage!)
                                : null,
                            onBackgroundImageError: (exception, stackTrace) {
                              debugPrint('DEBUG: Image load error: $exception');
                            },
                            child: client.profileImage == null
                                ? const Icon(
                                    Icons.store,
                                    size: 40,
                                    color: AppColors.jabaliBlue,
                                  )
                                : null,
                          ),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              client.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                shadows: [
                                  Shadow(
                                    offset: Offset(0, 2),
                                    blurRadius: 4,
                                    color: Colors.black45,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Wrap(
                              spacing: 8,
                              children: [
                                _buildGlassBadge(
                                  client.category ?? 'غير محدد',
                                  Colors.white,
                                ),
                                if (client.isAgent)
                                  _buildGlassBadge(
                                    'وكيل',
                                    AppColors.jabaliGold,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Camera Icon
            Positioned(
              bottom: 20,
              left: 20,
              child: GestureDetector(
                onTap: () => _changeProfileImage(context, ref, client),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassBadge(String text, Color color) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.2),
            border: Border.all(color: color.withValues(alpha: 0.5), width: 1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            text,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> children,
    Widget? trailing,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(icon, color: AppColors.jabaliBlue, size: 22),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F2F6)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSection(BuildContext context, Client client) {
    return _buildSectionCard(
      context: context,
      title: 'معلومات الاتصال',
      icon: Icons.contact_phone_outlined,
      children: [
        if (client.shopPhoneNumbers.isNotEmpty) ...[
          ...client.shopPhoneNumbers.map((phone) => _buildPhoneItem(phone)),
          const SizedBox(height: 16),
        ],
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 20,
              color: Colors.grey,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                client.address ?? 'لا يوجد عنوان',
                style: const TextStyle(
                  fontSize: 15,
                  height: 1.4,
                  color: Color(0xFF636E72),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildPhoneItem(String phone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFE9ECEF)),
      ),
      child: Row(
        children: [
          const Icon(Icons.phone_iphone, size: 20, color: AppColors.jabaliBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              phone,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Color(0xFF2D3436),
                letterSpacing: 0.5,
              ),
              textDirection: TextDirection.ltr,
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationSection(BuildContext context, Client client) {
    return _buildSectionCard(
      context: context,
      title: 'الموقع الجغرافي',
      icon: Icons.map_outlined,
      children: [
        GestureDetector(
          onTap: () => _openInMaps(context, client.gpsLocation!),
          child: Container(
            height: 160,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.grey.shade100,
              image: const DecorationImage(
                image: AssetImage(
                  'assets/images/map_placeholder.png',
                ), // You might want to add a placeholder asset
                fit: BoxFit.cover,
                opacity: 0.4,
              ),
            ),
            child: Stack(
              children: [
                // If you don't have a map placeholder, use a gradient
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.blue.shade50.withValues(alpha: 0.5),
                        Colors.blue.shade100.withValues(alpha: 0.5),
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.jabaliBlue.withValues(
                                alpha: 0.2,
                              ),
                              blurRadius: 15,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.location_on,
                          size: 32,
                          color: AppColors.jabaliBlue,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.9),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'فتح في الخريطة',
                          style: TextStyle(
                            color: AppColors.jabaliBlue,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildVisitInfoSection(BuildContext context, Client client) {
    return _buildSectionCard(
      context: context,
      title: 'معلومات الزيارة',
      icon: Icons.calendar_today_outlined,
      children: [
        _buildInfoRow(
          'آخر زيارة',
          client.lastVisit != null
              ? '${client.lastVisit!.year}-${client.lastVisit!.month.toString().padLeft(2, '0')}-${client.lastVisit!.day.toString().padLeft(2, '0')}'
              : 'غير محدد',
          Icons.history,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1),
        ),
        _buildInfoRow(
          'مستوى الولاء',
          client.loyaltyLevel ?? 'غير محدد',
          Icons.star_outline,
          valueColor: AppColors.jabaliGold,
        ),
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(height: 1),
        ),
        _buildInfoRow(
          'الأهمية',
          client.importance ?? 'C',
          Icons.priority_high,
          valueColor: _getImportanceColor(client.importance),
        ),
      ],
    );
  }

  Color _getImportanceColor(String? importance) {
    switch (importance) {
      case 'A':
        return AppColors.success;
      case 'B':
        return AppColors.warning;
      default:
        return AppColors.danger;
    }
  }

  Widget _buildInfoRow(
    String label,
    String value,
    IconData icon, {
    Color? valueColor,
  }) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey.shade400),
        const SizedBox(width: 8),
        Text(
          label,
          style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.bold,
            color: valueColor ?? const Color(0xFF2D3436),
          ),
        ),
      ],
    );
  }

  Widget _buildImagesSection(BuildContext context, Client client) {
    return _buildSectionCard(
      context: context,
      title: 'صور المحل',
      icon: Icons.photo_library_outlined,
      children: [
        SizedBox(
          height: 140,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: client.images?.length ?? 0,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ImageViewerScreen(
                        imagePaths: client.images ?? [],
                        initialIndex: index,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: 'client_image_${client.id}_$index',
                  child: Container(
                    margin: const EdgeInsets.only(left: 12),
                    width: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image(
                        image: _getImageProvider(client.images![index]),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey.shade200,
                            child: const Icon(
                              Icons.broken_image,
                              size: 40,
                              color: Colors.grey,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildDebugSection(BuildContext context, Client client) {
    return Container(
      padding: const EdgeInsets.all(16),
      margin: const EdgeInsets.only(top: 20),
      color: Colors.grey.shade200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Debug Info (For Troubleshooting)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('ID: ${client.id}'),
          Text('Remote ID: ${client.remoteId}'),
          Text('Profile Image Path: ${client.profileImage}'),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              if (client.profileImage == null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('No profile image path')),
                );
                return;
              }

              final path = client.profileImage!;
              String cleanPath = path.replaceAll('\\', '/');
              if (cleanPath.startsWith('/')) cleanPath = cleanPath.substring(1);
              final url = '${ApiConstants.storageUrl}/$cleanPath';
              final encodedUrl = Uri.encodeFull(url);

              debugPrint('Testing connection to: $encodedUrl');

              try {
                final response = await HttpClient()
                    .getUrl(Uri.parse(encodedUrl))
                    .then((request) => request.close());

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Status: ${response.statusCode}'),
                      backgroundColor: response.statusCode == 200
                          ? Colors.green
                          : Colors.red,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Test Image Connection'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmployeesSection(BuildContext context, Client client) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ClientEmployeesScreen(
              clientId: client.id,
              clientName: client.name,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 15,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Icon(
                Icons.people_alt_outlined,
                color: AppColors.jabaliBlue,
                size: 24,
              ),
            ),
            const SizedBox(width: 16),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'الموظفين',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2D3436),
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'إدارة الموظفين المرتبطين',
                    style: TextStyle(fontSize: 13, color: Color(0xFF636E72)),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFab(BuildContext context, WidgetRef ref) {
    return FloatingActionButton.extended(
      onPressed: () {
        final clientsAsync = ref.read(clientsProvider);
        clientsAsync.whenData((clients) {
          final client = clients.where((c) => c.id == clientId).firstOrNull;
          if (client != null) {
            PhoneSelectorDialog.show(context, client.shopPhoneNumbers);
          }
        });
      },
      backgroundColor: AppColors.jabaliBlue,
      foregroundColor: Colors.white,
      elevation: 4,
      icon: const Icon(Icons.phone),
      label: const Text(
        'اتصال',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  // ... Helper methods (same as before) ...
  void _changeProfileImage(
    BuildContext context,
    WidgetRef ref,
    Client client,
  ) async {
    final ImagePicker picker = ImagePicker();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.photo_camera),
                title: const Text('التقاط صورة'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? photo = await picker.pickImage(
                    source: ImageSource.camera,
                  );
                  if (photo != null) {
                    await ref
                        .read(clientControllerProvider.notifier)
                        .updateClient(
                          client
                              .copyWith(profileImage: drift.Value(photo.path))
                              .toCompanion(true),
                        );
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('اختيار من المعرض'),
                onTap: () async {
                  Navigator.pop(context);
                  final XFile? photo = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (photo != null) {
                    await ref
                        .read(clientControllerProvider.notifier)
                        .updateClient(
                          client
                              .copyWith(profileImage: drift.Value(photo.path))
                              .toCompanion(true),
                        );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _openInMaps(BuildContext context, String gpsLocation) async {
    final coords = gpsLocation.split(',');
    if (coords.length == 2) {
      final lat = coords[0];
      final lng = coords[1];

      // Use geo: scheme for showing location with a marker
      final geoUrl = Uri.parse('geo:$lat,$lng?q=$lat,$lng');

      // Fallback web URL
      final webUrl = Uri.parse(
        'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
      );

      try {
        if (await canLaunchUrl(geoUrl)) {
          await launchUrl(geoUrl);
        } else if (await canLaunchUrl(webUrl)) {
          await launchUrl(webUrl, mode: LaunchMode.externalApplication);
        } else {
          throw 'Could not launch maps';
        }
      } catch (e) {
        debugPrint('Error launching maps: $e');
        if (context.mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('تعذر فتح الخرائط')));
        }
      }
    }
  }

  ImageProvider _getImageProvider(String path) {
    debugPrint('DEBUG: _getImageProvider called with path: $path');
    if (path.startsWith('http')) {
      debugPrint('DEBUG: Returning NetworkImage: $path');
      return NetworkImage(path);
    } else if (File(path).existsSync()) {
      debugPrint('DEBUG: Returning FileImage: $path');
      return FileImage(File(path));
    } else {
      // Assume it's a relative path from server storage
      // 1. Replace backslashes with forward slashes (Windows fix)
      String cleanPath = path.replaceAll('\\', '/');

      // 2. Remove leading slash if present
      if (cleanPath.startsWith('/')) {
        cleanPath = cleanPath.substring(1);
      }

      // 3. Construct URL
      final url = '${ApiConstants.storageUrl}/$cleanPath';
      final encodedUrl = Uri.encodeFull(url);

      debugPrint('DEBUG: Constructed URL: $url');
      debugPrint('DEBUG: Encoded URL: $encodedUrl');

      // 4. Encode URL to handle Arabic characters and spaces
      return NetworkImage(encodedUrl);
    }
  }

  void _showDeleteDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف العميل'),
        content: const Text('هل أنت متأكد من حذف هذا العميل؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(clientControllerProvider.notifier)
                  .deleteClient(clientId);
              if (context.mounted) {
                Navigator.pop(context);
                Navigator.pop(context);
              }
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
