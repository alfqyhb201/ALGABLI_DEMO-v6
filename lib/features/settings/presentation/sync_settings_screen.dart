import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/sync_service.dart';
import '../../../core/widgets/app_card.dart';

class SyncSettingsScreen extends ConsumerStatefulWidget {
  const SyncSettingsScreen({super.key});

  @override
  ConsumerState<SyncSettingsScreen> createState() => _SyncSettingsScreenState();
}

class _SyncSettingsScreenState extends ConsumerState<SyncSettingsScreen> {
  bool _isSyncing = false;

  @override
  Widget build(BuildContext context) {
    final syncService = ref.watch(syncServiceProvider);
    final isAutoSync = syncService.isAutoSyncEnabled;

    return Scaffold(
      appBar: AppBar(
        title: const Text('إعدادات المزامنة'),
        backgroundColor: AppColors.jabaliBlue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            AppCard(
              child: Column(
                children: [
                  SwitchListTile(
                    title: const Text('المزامنة التلقائية'),
                    subtitle: const Text('مزامنة البيانات تلقائياً في الخلفية'),
                    value: isAutoSync,
                    activeThumbColor: AppColors.jabaliBlue,
                    onChanged: (value) {
                      setState(() {
                        if (value) {
                          syncService.enableAutoSync();
                        } else {
                          syncService.disableAutoSync();
                        }
                      });
                    },
                  ),
                  const Divider(),
                  ListTile(
                    title: const Text('مزامنة يدوية'),
                    subtitle: const Text('اضغط للمزامنة الآن'),
                    trailing: _isSyncing
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.sync, color: AppColors.jabaliBlue),
                    onTap: _isSyncing
                        ? null
                        : () async {
                            setState(() => _isSyncing = true);
                            try {
                              // Push pending items first
                              await syncService.syncPendingItems();
                              // Then pull new items
                              await syncService.pullClients();

                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('تمت المزامنة بنجاح'),
                                    backgroundColor: AppColors.success,
                                  ),
                                );
                              }
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('فشل المزامنة: $e'),
                                    backgroundColor: AppColors.danger,
                                  ),
                                );
                              }
                            } finally {
                              if (mounted) {
                                setState(() => _isSyncing = false);
                              }
                            }
                          },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'تأكد من الاتصال بالإنترنت لإتمام عملية المزامنة.',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
