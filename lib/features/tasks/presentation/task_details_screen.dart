import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';
import '../../../core/providers/clients_provider.dart';

class TaskDetailsScreen extends ConsumerWidget {
  final String taskId;

  const TaskDetailsScreen({super.key, required this.taskId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final taskAsync = ref.watch(taskByIdProvider(taskId));

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('تفاصيل المهمة'),
        actions: [
          taskAsync.when(
            data: (task) => IconButton(
              icon: const Icon(Icons.delete_outline, color: Colors.red),
              onPressed: () => _confirmDelete(context, ref, task),
            ),
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
          ),
        ],
      ),
      body: taskAsync.when(
        data: (task) => _buildContent(context, ref, task),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }

  Widget _buildContent(BuildContext context, WidgetRef ref, Task task) {
    final dateFormat = DateFormat('EEEE, d MMMM yyyy - h:mm a', 'ar');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(task),
          const SizedBox(height: 24),
          _buildInfoSection(context, ref, task, dateFormat),
          const SizedBox(height: 24),
          _buildChecklistSection(context, ref, task),
          const SizedBox(height: 24),
          _buildProgressSection(ref, task),
          const SizedBox(height: 24),
          _buildActions(context, ref, task),
        ],
      ),
    );
  }

  Widget _buildHeader(Task task) {
    Color statusColor;
    String statusText;
    switch (task.status) {
      case 'completed':
        statusColor = AppColors.success;
        statusText = 'مكتملة';
        break;
      case 'in_progress':
        statusColor = AppColors.jabaliBlue;
        statusText = 'قيد التنفيذ';
        break;
      case 'overdue':
        statusColor = AppColors.danger;
        statusText = 'متأخرة';
        break;
      default:
        statusColor = AppColors.warning;
        statusText = 'معلقة';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border(left: BorderSide(color: statusColor, width: 6)),
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              if (task.priority == 'high')
                const Row(
                  children: [
                    Icon(Icons.flag, color: AppColors.danger, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'أولوية عالية',
                      style: TextStyle(
                        color: AppColors.danger,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            task.title,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          if (task.description != null && task.description!.isNotEmpty) ...[
            const SizedBox(height: 8),
            HtmlWidget(
              task.description!,
              textStyle: const TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              onTapUrl: (url) async {
                final uri = Uri.parse(url);
                if (await canLaunchUrl(uri)) {
                  await launchUrl(uri);
                  return true;
                }
                return false;
              },
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoSection(
    BuildContext context,
    WidgetRef ref,
    Task task,
    DateFormat dateFormat,
  ) {
    return Column(
      children: [
        _buildInfoTile(
          icon: Icons.access_time,
          title: 'تاريخ الاستحقاق',
          value: task.dueAt != null
              ? dateFormat.format(task.dueAt!)
              : 'غير محدد',
          valueColor: task.status == 'overdue' ? AppColors.danger : null,
        ),
        if (task.clientId != null)
          Consumer(
            builder: (context, ref, child) {
              final clientAsync = ref.watch(clientProvider(task.clientId!));
              return clientAsync.when(
                data: (client) => _buildInfoTile(
                  icon: Icons.store,
                  title: 'العميل',
                  value: client.name,
                  onTap: () => context.push('/client-details/${client.id}'),
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              );
            },
          ),
        if (task.campaignId != null)
          Consumer(
            builder: (context, ref, child) {
              final campaignAsync = ref.watch(
                campaignByIdProvider(task.campaignId!),
              );
              return campaignAsync.when(
                data: (campaign) => _buildInfoTile(
                  icon: Icons.campaign,
                  title: 'الحملة',
                  value: campaign.title,
                ),
                loading: () => const SizedBox(),
                error: (_, __) => const SizedBox(),
              );
            },
          ),
      ],
    );
  }

  Widget _buildInfoTile({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.grey.shade100,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: Colors.grey.shade700, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        ),
        subtitle: Text(
          value,
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: valueColor ?? AppColors.textPrimary,
          ),
        ),
        trailing: onTap != null
            ? const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey)
            : null,
        onTap: onTap,
      ),
    );
  }

  Widget _buildChecklistSection(
    BuildContext context,
    WidgetRef ref,
    Task task,
  ) {
    final subTasksAsync = ref.watch(subTasksProvider(task.id));

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'قائمة المهام الفرعية',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.add_circle, color: AppColors.jabaliBlue),
                onPressed: () => _showAddSubTaskDialog(context, ref, task.id),
              ),
            ],
          ),
          const SizedBox(height: 12),
          subTasksAsync.when(
            data: (subTasks) {
              if (subTasks.isEmpty) {
                return const Text(
                  'لا توجد مهام فرعية',
                  style: TextStyle(color: Colors.grey),
                );
              }
              return Column(
                children: subTasks.map((subTask) {
                  return CheckboxListTile(
                    title: Text(
                      subTask.title,
                      style: TextStyle(
                        decoration: subTask.isCompleted
                            ? TextDecoration.lineThrough
                            : null,
                        color: subTask.isCompleted ? Colors.grey : Colors.black,
                      ),
                    ),
                    value: subTask.isCompleted,
                    onChanged: (value) {
                      ref.read(tasksControllerProvider).toggleSubTask(subTask);
                    },
                    secondary: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        size: 20,
                        color: Colors.grey,
                      ),
                      onPressed: () {
                        ref
                            .read(tasksControllerProvider)
                            .deleteSubTask(subTask.id, task.id);
                      },
                    ),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.zero,
                    activeColor: AppColors.jabaliBlue,
                  );
                }).toList(),
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (err, _) => Text('Error: $err'),
          ),
        ],
      ),
    );
  }

  Widget _buildProgressSection(WidgetRef ref, Task task) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'نسبة الإنجاز',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              Text(
                '${task.progressPercentage}%',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: AppColors.jabaliBlue,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: LinearProgressIndicator(
              value: task.progressPercentage / 100,
              minHeight: 10,
              backgroundColor: Colors.grey.shade200,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.jabaliBlue,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActions(BuildContext context, WidgetRef ref, Task task) {
    if (task.status == 'completed') {
      return SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: () {
            ref
                .read(tasksControllerProvider)
                .updateTaskStatus(task, 'in_progress');
            ref.read(tasksControllerProvider).updateTaskProgress(task, 50);
          },
          icon: const Icon(Icons.refresh),
          label: const Text('إعادة فتح المهمة'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppColors.jabaliBlue,
            side: const BorderSide(color: AppColors.jabaliBlue),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      );
    }

    return Row(
      children: [
        if (task.status == 'todo')
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ref
                    .read(tasksControllerProvider)
                    .updateTaskStatus(task, 'in_progress');
              },
              icon: const Icon(Icons.play_arrow),
              label: const Text('بدء المهمة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.jabaliBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        if (task.status == 'in_progress')
          Expanded(
            child: ElevatedButton.icon(
              onPressed: () {
                ref
                    .read(tasksControllerProvider)
                    .updateTaskStatus(task, 'completed');
                ref.read(tasksControllerProvider).updateTaskProgress(task, 100);
              },
              icon: const Icon(Icons.check),
              label: const Text('إكمال المهمة'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
      ],
    );
  }

  void _showAddSubTaskDialog(
    BuildContext context,
    WidgetRef ref,
    String taskId,
  ) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة مهمة فرعية'),
        content: TextField(
          controller: controller,
          decoration: const InputDecoration(hintText: 'عنوان المهمة الفرعية'),
          autofocus: true,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () {
              if (controller.text.isNotEmpty) {
                ref
                    .read(tasksControllerProvider)
                    .addSubTask(
                      SubTasksCompanion(
                        taskId: drift.Value(taskId),
                        title: drift.Value(controller.text),
                      ),
                    );
                Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Task task) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف المهمة'),
        content: const Text('هل أنت متأكد من رغبتك في حذف هذه المهمة؟'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await ref.read(tasksControllerProvider).deleteTask(task.id);
              if (context.mounted) context.pop();
            },
            child: const Text('حذف', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
