import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/grid_background.dart';
import '../widgets/manager_drawer.dart';

class ManagerDashboardScreen extends StatelessWidget {
  const ManagerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGridBackground,
      drawer: const ManagerDrawer(),
      body: GridBackground(
        child: Column(
          children: [
            Builder(
              builder: (context) => AppHeader(
                title: 'لوحة تحكم المدير',
                showBackButton: false,
                onMenuPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildKPISection(),
                    const SizedBox(height: 24),
                    const Text(
                      'الأداء العام',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildPerformanceChart(),
                    const SizedBox(height: 24),
                    const Text(
                      'إجراءات سريعة',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildQuickActions(context),
                    const SizedBox(height: 24),
                    const Text(
                      'آخر النشاطات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRecentActivity(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildKPISection() {
    return Row(
      children: [
        Expanded(
          child: _buildKPICard(
            'إجمالي المبيعات',
            '54,200',
            Icons.attach_money,
            AppColors.success,
            '+12%',
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _buildKPICard(
            'الزيارات النشطة',
            '1,250',
            Icons.location_on,
            AppColors.jabaliBlue,
            '+5%',
          ),
        ),
      ],
    );
  }

  Widget _buildKPICard(
    String title,
    String value,
    IconData icon,
    Color color,
    String trend,
  ) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color, size: 24),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.success.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  trend,
                  style: const TextStyle(
                    color: AppColors.success,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              // color: Colors.white, // Removed to use default theme color
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart() {
    return AppCard(
      child: SizedBox(
        height: 200,
        child: LineChart(
          LineChartData(
            gridData: FlGridData(show: false),
            titlesData: FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            minX: 0,
            maxX: 6,
            minY: 0,
            maxY: 6,
            lineBarsData: [
              LineChartBarData(
                spots: [
                  const FlSpot(0, 3),
                  const FlSpot(1, 1),
                  const FlSpot(2, 4),
                  const FlSpot(3, 2),
                  const FlSpot(4, 5),
                  const FlSpot(5, 3),
                  const FlSpot(6, 4),
                ],
                isCurved: true,
                color: AppColors.jabaliBlue,
                dotData: FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Row(
      children: [
        _buildActionButton(
          context,
          'إدارة الحملات',
          Icons.campaign,
          AppColors.jabaliRed,
          () {},
        ),
        const SizedBox(width: 12),
        _buildActionButton(
          context,
          'أداء الفريق',
          Icons.groups,
          AppColors.jabaliBlue,
          () {},
        ),
        const SizedBox(width: 12),
        _buildActionButton(
          context,
          'التقارير',
          Icons.bar_chart,
          AppColors.jabaliGold,
          () {},
        ),
      ],
    );
  }

  Widget _buildActionButton(
    BuildContext context,
    String label,
    IconData icon,
    Color color,
    VoidCallback onTap,
  ) {
    return Expanded(
      child: AppCard(
        onTap: onTap,
        child: Column(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: color.withValues(alpha: 0.2),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                // color: Colors.white, // Removed
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentActivity() {
    return Column(
      children: [
        _buildActivityItem(
          'تم إنشاء حملة جديدة',
          'قبل 2 ساعة',
          Icons.add_circle,
          AppColors.jabaliBlue,
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          'تقرير مبيعات جديد',
          'قبل 5 ساعات',
          Icons.description,
          AppColors.success,
        ),
        const SizedBox(height: 12),
        _buildActivityItem(
          'تنبيه انخفاض المبيعات',
          'أمس',
          Icons.warning,
          AppColors.danger,
        ),
      ],
    );
  }

  Widget _buildActivityItem(
    String title,
    String time,
    IconData icon,
    Color color,
  ) {
    return AppCard(
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    // color: Colors.white, // Removed
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  time,
                  style: const TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.arrow_forward_ios,
            color: AppColors.textSecondary,
            size: 16,
          ),
        ],
      ),
    );
  }
}
