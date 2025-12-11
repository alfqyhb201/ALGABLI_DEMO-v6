import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';

class ManagerDrawer extends StatelessWidget {
  const ManagerDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard,
                  title: 'لوحة التحكم',
                  route: '/manager-home',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.campaign,
                  title: 'إدارة الحملات',
                  route: '/manager-campaigns',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.groups,
                  title: 'أداء الفريق',
                  route: '/team-performance',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.bar_chart,
                  title: 'التقارير المتقدمة',
                  route: '/manager-reports',
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.manage_accounts,
                  title: 'إدارة المستخدمين',
                  route: '/user-management',
                ),
                const Divider(color: Colors.grey),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings,
                  title: 'الإعدادات',
                  route: '/settings',
                ),
              ],
            ),
          ),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 60, 16, 20),
      decoration: const BoxDecoration(color: AppColors.jabaliBlue),
      child: Row(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: Colors.white,
            child: const Icon(
              Icons.person,
              color: AppColors.jabaliBlue,
              size: 30,
            ),
          ),
          const SizedBox(width: 16),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'المدير العام',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'admin@aljabali.com',
                style: TextStyle(color: Colors.white70, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String route,
  }) {
    final isSelected = GoRouterState.of(context).uri.toString() == route;
    return ListTile(
      leading: Icon(
        icon,
        color: isSelected ? AppColors.jabaliBlue : Colors.grey,
      ),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? AppColors.jabaliBlue : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
      selected: isSelected,
      selectedTileColor: AppColors.jabaliBlue.withValues(alpha: 0.1),
      onTap: () {
        context.pop(); // Close drawer
        context.push(route);
      },
    );
  }

  Widget _buildLogoutButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListTile(
        leading: const Icon(Icons.logout, color: AppColors.danger),
        title: const Text(
          'تسجيل الخروج',
          style: TextStyle(
            color: AppColors.danger,
            fontWeight: FontWeight.bold,
          ),
        ),
        onTap: () {
          context.go('/login');
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: BorderSide(color: AppColors.danger.withValues(alpha: 0.5)),
        ),
      ),
    );
  }
}
