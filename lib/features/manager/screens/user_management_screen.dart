import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/grid_background.dart';
import '../widgets/manager_drawer.dart';

class UserManagementScreen extends StatelessWidget {
  const UserManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGridBackground,
      drawer: const ManagerDrawer(),
      body: GridBackground(
        child: Column(
          children: [
            const AppHeader(title: 'إدارة المستخدمين', showBackButton: true),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 6,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildUserCard(index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to add user screen
        },
        icon: const Icon(Icons.person_add),
        label: const Text('إضافة مستخدم'),
        backgroundColor: AppColors.jabaliBlue,
      ),
    );
  }

  Widget _buildUserCard(int index) {
    final isActive = index % 3 != 0;
    return AppCard(
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: AppColors.jabaliBlue.withValues(alpha: 0.2),
            child: const Icon(Icons.person, color: AppColors.jabaliBlue),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'المستخدم ${index + 1}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'مسوق ميداني',
                  style: TextStyle(fontSize: 12, color: Colors.white54),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isActive ? AppColors.success : AppColors.danger)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  isActive ? 'نشط' : 'غير نشط',
                  style: TextStyle(
                    color: isActive ? AppColors.success : AppColors.danger,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(
                      Icons.edit,
                      size: 20,
                      color: Colors.white70,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                  const SizedBox(width: 12),
                  IconButton(
                    icon: const Icon(
                      Icons.delete,
                      size: 20,
                      color: AppColors.danger,
                    ),
                    onPressed: () {},
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
