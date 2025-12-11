import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/theme_provider.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text(
          'الإعدادات',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: AppColors.jabaliBlue,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionHeader(context, 'عام'),
          _buildSettingsTile(
            context,
            icon: Icons.sync,
            title: 'إعدادات المزامنة',
            subtitle: 'التحكم في المزامنة التلقائية واليدوية',
            onTap: () => context.push('/settings/sync'),
            iconColor: Colors.blue,
          ),
          _buildSettingsTile(
            context,
            icon: isDark ? Icons.dark_mode : Icons.light_mode,
            title: 'المظهر',
            subtitle: isDark ? 'الوضع الليلي' : 'الوضع النهاري',
            trailing: Switch(
              value: isDark,
              onChanged: (value) {
                ref.read(themeProvider.notifier).toggleTheme();
              },
              activeThumbColor: AppColors.jabaliBlue,
            ),
            iconColor: Colors.purple,
          ),

          const SizedBox(height: 24),
          _buildSectionHeader(context, 'الحساب'),
          _buildSettingsTile(
            context,
            icon: Icons.person_outline,
            title: 'الملف الشخصي',
            subtitle: 'تعديل بياناتك الشخصية',
            onTap: () => context.push('/profile'),
            iconColor: Colors.orange,
          ),
          _buildSettingsTile(
            context,
            icon: Icons.lock_outline,
            title: 'تغيير كلمة المرور',
            onTap: () {}, // TODO: Implement change password
            iconColor: Colors.redAccent,
          ),

          const SizedBox(height: 24),
          _buildSectionHeader(context, 'الدعم'),
          _buildSettingsTile(
            context,
            icon: Icons.help_outline,
            title: 'المساعدة والدعم',
            onTap: () => context.push('/help'),
            iconColor: Colors.green,
          ),
          _buildSettingsTile(
            context,
            icon: Icons.info_outline,
            title: 'عن التطبيق',
            subtitle: 'الإصدار 1.0.0',
            onTap: () {},
            iconColor: Colors.teal,
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12, right: 8),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
          color: AppColors.jabaliBlue.withValues(alpha: 0.8),
        ),
      ),
    );
  }

  Widget _buildSettingsTile(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    VoidCallback? onTap,
    Widget? trailing,
    Color? iconColor,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: (iconColor ?? AppColors.jabaliBlue).withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: iconColor ?? AppColors.jabaliBlue, size: 24),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: subtitle != null
            ? Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Theme.of(context).textTheme.bodySmall?.color,
                ),
              )
            : null,
        trailing:
            trailing ??
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }
}
