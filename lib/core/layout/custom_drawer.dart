import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../constants/app_colors.dart';
import '../providers/theme_provider.dart';

class CustomDrawer extends ConsumerWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Drawer(
      child: Column(
        children: [
          _buildHeader(context),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(vertical: 8),
              children: [
                _buildDrawerItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'الرئيسية',
                  onTap: () {
                    Navigator.pop(context);
                    context.go('/home');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.store_outlined,
                  title: 'العملاء',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/clients');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.task_alt_outlined,
                  title: 'المهام',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/tasks');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.analytics_outlined,
                  title: 'التقارير',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/reports');
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.settings_outlined,
                  title: 'الإعدادات',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/settings');
                  },
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.admin_panel_settings_outlined,
                  title: 'لوحة المدير',
                  onTap: () {
                    Navigator.pop(context);
                    context.push('/manager-login');
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.1)
                          : Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      isDark ? Icons.dark_mode : Icons.light_mode,
                      color: Theme.of(context).iconTheme.color,
                      size: 20,
                    ),
                  ),
                  title: Text(
                    'الوضع الليلي',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  trailing: Switch(
                    value: isDark,
                    onChanged: (value) {
                      ref.read(themeProvider.notifier).toggleTheme();
                    },
                    activeColor: AppColors.jabaliGold,
                  ),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.help_outline,
                  title: 'المساعدة والدعم',
                  onTap: () {
                    Navigator.pop(context);
                    // context.push('/help');
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: Divider(),
                ),
                _buildDrawerItem(
                  context,
                  icon: Icons.logout_rounded,
                  title: 'تسجيل الخروج',
                  textColor: AppColors.danger,
                  iconColor: AppColors.danger,
                  onTap: () {
                    Navigator.pop(context);
                    _showLogoutDialog(context);
                  },
                ),
              ],
            ),
          ),
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.jabaliBlue,
            Color(0xFF1A237E), // Darker shade
          ],
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.2),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: const CircleAvatar(
              radius: 35,
              backgroundColor: AppColors.background,
              child: Icon(Icons.person, size: 40, color: AppColors.jabaliBlue),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'أحمد محمد',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'مندوب مبيعات',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? textColor,
    Color? iconColor,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.05)
              : Colors.grey.shade100,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(
          icon,
          color: iconColor ?? Theme.of(context).iconTheme.color,
          size: 20,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: textColor ?? Theme.of(context).textTheme.bodyMedium?.color,
          fontWeight: FontWeight.w600,
          fontSize: 14,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Theme.of(context).dividerColor)),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.business, size: 20, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                'نظام الجبلي الميداني',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'الإصدار 1.0.0',
            style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Row(
            children: [
              Icon(Icons.logout, color: AppColors.danger),
              SizedBox(width: 8),
              Text('تسجيل الخروج'),
            ],
          ),
          content: const Text('هل أنت متأكد من رغبتك في تسجيل الخروج؟'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('إلغاء'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                context.go('/login');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.danger,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('تسجيل الخروج'),
            ),
          ],
        );
      },
    );
  }
}
