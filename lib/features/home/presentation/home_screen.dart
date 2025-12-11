import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/layout/custom_drawer.dart';
import '../../campaigns/domain/campaign_model.dart';
import '../../campaigns/presentation/widgets/campaign_card.dart';
import 'widgets/recent_tasks_list.dart';
import '../../../core/services/auth_service.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: AppColors.background,
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
              vertical: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeader(scaffoldKey, ref),
                const SizedBox(height: 24),
                _buildSummaryCard(),
                const SizedBox(height: 24),
                const Text(
                  'حملاتي',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 12),
                _buildCampaignsList(context),
                const SizedBox(height: 24),
                const Text(
                  'إجراءات سريعة',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                _buildQuickActions(context, ref),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'آخر الأنشطة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    TextButton(onPressed: () {}, child: const Text('عرض الكل')),
                  ],
                ),
                const SizedBox(height: 8),
                const RecentTasksList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCampaignsList(BuildContext context) {
    if (dummyCampaigns.isEmpty) {
      return const SizedBox(
        height: 150,
        child: Center(child: Text('لا توجد حملات حالياً')),
      );
    }

    return SizedBox(
      height: 220,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: dummyCampaigns.length,
        itemBuilder: (context, index) {
          return Container(
            width: 300,
            margin: const EdgeInsets.only(left: 12.0),
            child: CampaignCard(
              campaign: dummyCampaigns[index],
              onTap: () {
                context.push('/campaigns/${dummyCampaigns[index].id}');
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildHeader(GlobalKey<ScaffoldState> scaffoldKey, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final userName = currentUser?['user']?['name'] ?? 'المستخدم';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              scaffoldKey.currentState?.openDrawer();
            },
            color: AppColors.textPrimary,
          ),
        ),
        Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  children: [
                    const Text(
                      'مرحباً بك',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(
                      Icons.wb_sunny_rounded,
                      color: Colors.orange,
                      size: 16,
                    ),
                  ],
                ),
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            const SizedBox(width: 12),
            const CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage('assets/images/icon.png'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSummaryCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF0F172A), // Dark Blue
        borderRadius: BorderRadius.circular(24),
        image: const DecorationImage(
          image: AssetImage('assets/images/banner_card.png'),
          opacity: 0.05,
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'ملخص اليوم',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  '15 أغسطس',
                  style: TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildSummaryItem('مهام\nمتبقية', '5', Colors.white),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildSummaryItem('تمت\nزيارتهم', '2', Colors.lightBlueAccent),
              Container(width: 1, height: 40, color: Colors.white24),
              _buildSummaryItem('الإنجاز', '40%', AppColors.danger),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryItem(String label, String value, Color valueColor) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: valueColor,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white70,
            fontSize: 12,
            height: 1.2,
          ),
        ),
      ],
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    final currentUser = ref.watch(currentUserProvider);
    final permissions = List<String>.from(currentUser?['permissions'] ?? []);
    final hasReportsPermission =
        permissions.contains('view_reports') || permissions.isEmpty;

    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            title: 'العملاء',
            subtitle: 'عرض القائمة',
            icon: Icons.people_outline,
            color: const Color(0xFFFFF1F2),
            iconColor: const Color(0xFFE11D48),
            onTap: () => context.go('/customers'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildActionCard(
            title: 'مهامي',
            subtitle: 'المهام الحالية',
            icon: Icons.flash_on_rounded,
            color: const Color(0xFFEFF6FF),
            iconColor: const Color(0xFF2563EB),
            onTap: () => context.go('/tasks'),
          ),
        ),
        if (hasReportsPermission) ...[
          const SizedBox(width: 16),
          Expanded(
            child: _buildActionCard(
              title: 'التقارير',
              subtitle: 'عرض الإحصائيات',
              icon: Icons.bar_chart_rounded,
              color: const Color(0xFFECFDF5),
              iconColor: const Color(0xFF059669),
              onTap: () => context.go('/reports'),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildActionCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        height: 140,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.03),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: color, shape: BoxShape.circle),
              child: Icon(icon, color: iconColor, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              subtitle,
              style: const TextStyle(
                fontSize: 11,
                color: AppColors.textSecondary,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
