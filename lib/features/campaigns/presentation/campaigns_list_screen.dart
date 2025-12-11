import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';

class CampaignsListScreen extends ConsumerWidget {
  const CampaignsListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(allCampaignsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('الحملات')),
      body: campaignsAsync.when(
        data: (campaigns) {
          if (campaigns.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.campaign_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'لا توجد حملات حالياً',
                    style: TextStyle(color: Colors.grey, fontSize: 18),
                  ),
                ],
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: campaigns.length,
            separatorBuilder: (context, index) => const SizedBox(height: 16),
            itemBuilder: (context, index) =>
                _CampaignCard(campaign: campaigns[index]),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Navigate to create campaign (or show dialog)
      //     // For now, just a placeholder or simple dialog
      //     _showAddCampaignDialog(context, ref);
      //   },
      //   label: const Text('حملة جديدة'),
      //   icon: const Icon(Icons.add),
      //   backgroundColor: AppColors.primary,
      // ),
    );
  }

  /*
  void _showAddCampaignDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة حملة جديدة'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(labelText: 'عنوان الحملة'),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(labelText: 'الوصف'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              // Simple add for now
              /*
              final campaign = CampaignsCompanion(
                title: drift.Value(titleController.text),
                description: drift.Value(descriptionController.text),
                startDate: drift.Value(DateTime.now()),
                endDate: drift.Value(DateTime.now().add(const Duration(days: 30))),
              );
              await ref.read(campaignsControllerProvider).addCampaign(campaign);
              */
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('سيتم إضافة شاشة إنشاء الحملة قريباً'),
                ),
              );
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
  */
}

class _CampaignCard extends ConsumerWidget {
  final Campaign campaign;

  const _CampaignCard({required this.campaign});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasksAsync = ref.watch(tasksByCampaignProvider(campaign.id));
    final dateFormat = DateFormat('d MMM yyyy', 'ar');

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () => context.push('/campaigns/${campaign.id}'),
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.campaign,
                      color: AppColors.primary,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          campaign.title,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${campaign.startDate != null ? dateFormat.format(campaign.startDate!) : 'غير محدد'} - ${campaign.endDate != null ? dateFormat.format(campaign.endDate!) : 'غير محدد'}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: campaign.status == 'active'
                          ? AppColors.success.withValues(alpha: 0.1)
                          : Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      campaign.status == 'active' ? 'نشطة' : 'منتهية',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: campaign.status == 'active'
                            ? AppColors.success
                            : Colors.grey,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              tasksAsync.when(
                data: (tasks) {
                  final totalTasks = tasks.length;
                  final completedTasks = tasks
                      .where((t) => t.status == 'completed')
                      .length;
                  final progress = totalTasks > 0
                      ? completedTasks / totalTasks
                      : 0.0;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'الإنجاز ($completedTasks من $totalTasks مهمة)',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                          Text(
                            '${(progress * 100).toInt()}%',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: progress,
                          backgroundColor: Colors.grey.shade100,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            AppColors.primary,
                          ),
                          minHeight: 6,
                        ),
                      ),
                    ],
                  );
                },
                loading: () => const LinearProgressIndicator(minHeight: 6),
                error: (_, __) => const SizedBox(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
