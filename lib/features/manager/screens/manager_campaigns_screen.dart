import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/grid_background.dart';
import '../widgets/manager_drawer.dart';

class ManagerCampaignsScreen extends StatelessWidget {
  const ManagerCampaignsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGridBackground,
      drawer: const ManagerDrawer(),
      body: GridBackground(
        child: Column(
          children: [
            const AppHeader(title: 'إدارة الحملات', showBackButton: true),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: 5,
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return _buildCampaignCard(context, index);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Navigate to create campaign screen (to be implemented)
        },
        icon: const Icon(Icons.add),
        label: const Text('حملة جديدة'),
        backgroundColor: AppColors.jabaliRed,
      ),
    );
  }

  Widget _buildCampaignCard(BuildContext context, int index) {
    return AppCard(
      onTap: () {
        // Navigate to campaign details
        context.push('/campaigns/$index');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  'نشطة',
                  style: TextStyle(
                    color: AppColors.jabaliBlue,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              PopupMenuButton(
                icon: const Icon(Icons.more_vert, color: Colors.white70),
                itemBuilder: (context) => [
                  const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                  const PopupMenuItem(
                    value: 'delete',
                    child: Text(
                      'حذف',
                      style: TextStyle(color: AppColors.danger),
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'حملة الترويج الصيفي ${index + 1}',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(Icons.calendar_today, size: 14, color: Colors.white54),
              SizedBox(width: 4),
              Text(
                '1 يونيو - 30 أغسطس',
                style: TextStyle(color: Colors.white54, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressIndicator(0.7),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _StatItem(label: 'الميزانية', value: '\$5,000'),
              _StatItem(label: 'المصروف', value: '\$3,200'),
              _StatItem(label: 'الزيارات', value: '150'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildProgressIndicator(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'نسبة الإنجاز',
              style: TextStyle(color: Colors.white70, fontSize: 12),
            ),
            Text(
              '${(progress * 100).toInt()}%',
              style: const TextStyle(
                color: AppColors.jabaliGold,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: LinearProgressIndicator(
            value: progress,
            backgroundColor: Colors.white10,
            valueColor: const AlwaysStoppedAnimation<Color>(
              AppColors.jabaliGold,
            ),
            minHeight: 6,
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final String label;
  final String value;

  const _StatItem({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
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
