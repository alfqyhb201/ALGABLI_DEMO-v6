import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/grid_background.dart';
import '../widgets/manager_drawer.dart';

class TeamPerformanceScreen extends StatelessWidget {
  const TeamPerformanceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGridBackground,
      drawer: const ManagerDrawer(),
      body: GridBackground(
        child: Column(
          children: [
            const AppHeader(title: 'أداء الفريق', showBackButton: true),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 8,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildTeamMemberCard(index);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTeamMemberCard(int index) {
    return AppCard(
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: AppColors.jabaliBlue.withValues(alpha: 0.2),
                child: Text(
                  'M${index + 1}',
                  style: const TextStyle(
                    color: AppColors.jabaliBlue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'مسوق ${index + 1}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'المنطقة: صنعاء - حدة',
                      style: TextStyle(fontSize: 12, color: Colors.white54),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.star, color: AppColors.jabaliGold, size: 14),
                    SizedBox(width: 4),
                    Text(
                      '4.8',
                      style: TextStyle(
                        color: AppColors.success,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(color: Colors.white10),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(
                label: 'الزيارات',
                value: '145',
                color: AppColors.jabaliBlue,
              ),
              _StatItem(
                label: 'المبيعات',
                value: '42',
                color: AppColors.success,
              ),
              _StatItem(
                label: 'العملاء الجدد',
                value: '12',
                color: AppColors.jabaliGold,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;
  final Color color;

  const _StatItem({
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white54, fontSize: 12),
        ),
      ],
    );
  }
}
