import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';

class CampaignDetailsScreen extends ConsumerWidget {
  final int campaignId;

  const CampaignDetailsScreen({super.key, required this.campaignId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignAsync = ref.watch(campaignByIdProvider(campaignId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تفاصيل الحملة'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: campaignAsync.when(
        data: (campaign) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(campaign),
              const SizedBox(height: 24),
              _buildStats(ref, campaign),
              const SizedBox(height: 24),
              _buildAssignedTasks(context, ref, campaign),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add task to this campaign
          context.push('/create-task'); // Ideally pre-fill campaign ID
        },
        label: const Text('إضافة مهمة'),
        icon: const Icon(Icons.add_task),
        backgroundColor: AppColors.primary,
      ),
    );
  }

  Widget _buildHeader(Campaign campaign) {
    final dateFormat = DateFormat('d MMM yyyy', 'ar');

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
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
                  size: 28,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaign.status == 'active' ? 'نشطة حالياً' : 'غير نشطة',
                      style: TextStyle(
                        fontSize: 12,
                        color: campaign.status == 'active'
                            ? AppColors.success
                            : AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Text(
            'الوصف:',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
          ),
          const SizedBox(height: 4),
          Text(
            campaign.description ?? 'لا يوجد وصف',
            style: const TextStyle(color: AppColors.textSecondary, height: 1.5),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                '${campaign.startDate != null ? dateFormat.format(campaign.startDate!) : 'غير محدد'} - ${campaign.endDate != null ? dateFormat.format(campaign.endDate!) : 'غير محدد'}',
                style: const TextStyle(color: Colors.grey, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStats(WidgetRef ref, Campaign campaign) {
    final tasksAsync = ref.watch(tasksByCampaignProvider(campaign.id));

    return tasksAsync.when(
      data: (tasks) {
        final totalTasks = tasks.length;
        final completedTasks = tasks
            .where((t) => t.status == 'completed')
            .length;
        final remainingTasks = totalTasks - completedTasks;

        return Row(
          children: [
            Expanded(
              child: _buildStatCard(
                'المهام المنجزة',
                completedTasks.toString(),
                Icons.check_circle_outline,
                AppColors.success,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildStatCard(
                'المهام المتبقية',
                remainingTasks.toString(),
                Icons.pending_actions,
                AppColors.warning,
              ),
            ),
          ],
        );
      },
      loading: () => const SizedBox(
        height: 100,
        child: Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => const SizedBox(),
    );
  }

  Widget _buildStatCard(
    String title,
    String value,
    IconData icon,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 28),
          const SizedBox(height: 8),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAssignedTasks(
    BuildContext context,
    WidgetRef ref,
    Campaign campaign,
  ) {
    final tasksAsync = ref.watch(tasksByCampaignProvider(campaign.id));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'المهام المرتبطة',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        tasksAsync.when(
          data: (tasks) {
            if (tasks.isEmpty) {
              return const Center(
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text('لا توجد مهام مرتبطة بهذه الحملة'),
                ),
              );
            }
            return ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: tasks.length,
              separatorBuilder: (context, index) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final task = tasks[index];
                return CheckboxListTile(
                  value: task.status == 'completed',
                  onChanged: (value) {
                    if (value == true) {
                      ref
                          .read(tasksControllerProvider)
                          .updateTaskStatus(task, 'completed');
                      ref
                          .read(tasksControllerProvider)
                          .updateTaskProgress(task, 100);
                    } else {
                      ref
                          .read(tasksControllerProvider)
                          .updateTaskStatus(task, 'in_progress');
                      ref
                          .read(tasksControllerProvider)
                          .updateTaskProgress(task, 0);
                    }
                  },
                  title: Text(
                    task.title,
                    style: TextStyle(
                      decoration: task.status == 'completed'
                          ? TextDecoration.lineThrough
                          : null,
                      color: task.status == 'completed'
                          ? Colors.grey
                          : AppColors.textPrimary,
                    ),
                  ),
                  subtitle: task.description != null
                      ? Text(
                          task.description!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      : null,
                  secondary: CircleAvatar(
                    backgroundColor: task.status == 'completed'
                        ? AppColors.success.withValues(alpha: 0.1)
                        : Colors.blue.shade50,
                    child: Icon(
                      task.status == 'completed' ? Icons.check : Icons.task,
                      color: task.status == 'completed'
                          ? AppColors.success
                          : Colors.blue,
                      size: 20,
                    ),
                  ),
                  activeColor: AppColors.success,
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 4,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(color: Colors.grey.shade200),
                  ),
                  tileColor: Colors.white,
                );
              },
            );
          },
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, stack) => Text('Error: $err'),
        ),
      ],
    );
  }
}
