import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class ActivityLogScreen extends StatelessWidget {
  const ActivityLogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('سجل النشاطات')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: _activities.length,
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          final activity = _activities[index];
          return _buildActivityCard(activity);
        },
      ),
    );
  }

  Widget _buildActivityCard(ActivityItem activity) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: activity.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(activity.icon, color: activity.color, size: 24),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    activity.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    activity.description,
                    style: const TextStyle(color: Colors.grey, fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    activity.time,
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ActivityItem {
  final String title;
  final String description;
  final String time;
  final IconData icon;
  final Color color;

  ActivityItem({
    required this.title,
    required this.description,
    required this.time,
    required this.icon,
    required this.color,
  });
}

final List<ActivityItem> _activities = [
  ActivityItem(
    title: 'تم إضافة عميل جديد',
    description: 'الجبلي - حدة، صنعاء',
    time: 'منذ 30 دقيقة',
    icon: Icons.person_add,
    color: AppColors.success,
  ),
  ActivityItem(
    title: 'تم إكمال مهمة',
    description: 'الجبلي ',
    time: 'منذ ساعة',
    icon: Icons.check_circle,
    color: AppColors.jabaliBlue,
  ),
  ActivityItem(
    title: 'تم رفع تقرير',
    description: 'تقرير الزيارة اليومية',
    time: 'منذ ساعتين',
    icon: Icons.upload_file,
    color: AppColors.warning,
  ),
  ActivityItem(
    title: 'تحديث بيانات عميل',
    description: 'الجبلي - حدة، صنعاء',
    time: 'منذ 3 ساعات',
    icon: Icons.edit,
    color: AppColors.jabaliRed,
  ),
  ActivityItem(
    title: 'بدء حملة جديدة',
    description: 'حملة الترويج الصيفية',
    time: 'اليوم 9:00 ص',
    icon: Icons.campaign,
    color: AppColors.jabaliBlue,
  ),
];
