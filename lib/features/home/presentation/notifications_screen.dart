import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإشعارات')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemCount: 5,
        separatorBuilder: (context, index) => const Divider(),
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: AppColors.primary.withValues(alpha: 0.1),
              child: const Icon(Icons.notifications, color: AppColors.primary),
            ),
            title: Text('إشعار جديد ${index + 1}'),
            subtitle: const Text('تم تعيين مهمة جديدة لك في منطقة حدة'),
            trailing: const Text('10:30 ص', style: TextStyle(fontSize: 12, color: Colors.grey)),
            onTap: () {},
          );
        },
      ),
    );
  }
}
