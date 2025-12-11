import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/grid_background.dart';
import '../widgets/manager_drawer.dart';

class ManagerReportsScreen extends StatelessWidget {
  const ManagerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.lightGridBackground,
      drawer: const ManagerDrawer(),
      body: GridBackground(
        child: Column(
          children: [
            const AppHeader(title: 'التقارير المتقدمة', showBackButton: true),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildDateFilter(),
                    const SizedBox(height: 24),
                    _buildSalesOverview(),
                    const SizedBox(height: 24),
                    const Text(
                      'تحليل المناطق',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildRegionAnalysis(),
                    const SizedBox(height: 24),
                    const Text(
                      'أداء المنتجات',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildProductPerformance(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _FilterChip(label: 'اليوم', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'هذا الأسبوع', isSelected: true),
          const SizedBox(width: 8),
          _FilterChip(label: 'هذا الشهر', isSelected: false),
          const SizedBox(width: 8),
          _FilterChip(label: 'مخصص', isSelected: false),
        ],
      ),
    );
  }

  Widget _buildSalesOverview() {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'نظرة عامة على المبيعات',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
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
                      const FlSpot(1, 4),
                      const FlSpot(2, 3.5),
                      const FlSpot(3, 5),
                      const FlSpot(4, 4),
                      const FlSpot(5, 6),
                      const FlSpot(6, 5.5),
                    ],
                    isCurved: true,
                    color: AppColors.jabaliGold,
                    dotData: FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: AppColors.jabaliGold.withValues(alpha: 0.1),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 16),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatColumn(label: 'إجمالي المبيعات', value: '245,000 ر.ي'),
              _StatColumn(label: 'متوسط الطلب', value: '12,500 ر.ي'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRegionAnalysis() {
    return AppCard(
      child: Column(
        children: [
          _RegionRow(name: 'صنعاء - حدة', percentage: 0.8, value: '85%'),
          const SizedBox(height: 16),
          _RegionRow(name: 'صنعاء - الستين', percentage: 0.65, value: '65%'),
          const SizedBox(height: 16),
          _RegionRow(name: 'صنعاء - الصافية', percentage: 0.45, value: '45%'),
          const SizedBox(height: 16),
          _RegionRow(name: 'صنعاء - التحرير', percentage: 0.3, value: '30%'),
        ],
      ),
    );
  }

  Widget _buildProductPerformance() {
    return AppCard(
      child: Column(
        children: [
          _ProductRow(
            name: 'منتج أ',
            sales: '1,200',
            growth: '+15%',
            isPositive: true,
          ),
          const Divider(color: Colors.white10),
          _ProductRow(
            name: 'منتج ب',
            sales: '850',
            growth: '-5%',
            isPositive: false,
          ),
          const Divider(color: Colors.white10),
          _ProductRow(
            name: 'منتج ج',
            sales: '620',
            growth: '+8%',
            isPositive: true,
          ),
        ],
      ),
    );
  }
}

class _FilterChip extends StatelessWidget {
  final String label;
  final bool isSelected;

  const _FilterChip({required this.label, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? AppColors.jabaliBlue : AppColors.darkCard,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isSelected ? AppColors.jabaliBlue : Colors.white24,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.white70,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}

class _StatColumn extends StatelessWidget {
  final String label;
  final String value;

  const _StatColumn({required this.label, required this.value});

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

class _RegionRow extends StatelessWidget {
  final String name;
  final double percentage;
  final String value;

  const _RegionRow({
    required this.name,
    required this.percentage,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 3,
          child: Text(name, style: const TextStyle(color: Colors.white)),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percentage,
              backgroundColor: Colors.white10,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.jabaliBlue,
              ),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class _ProductRow extends StatelessWidget {
  final String name;
  final String sales;
  final String growth;
  final bool isPositive;

  const _ProductRow({
    required this.name,
    required this.sales,
    required this.growth,
    required this.isPositive,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name, style: const TextStyle(color: Colors.white)),
          Row(
            children: [
              Text(
                sales,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 16),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isPositive ? AppColors.success : AppColors.danger)
                      .withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  growth,
                  style: TextStyle(
                    color: isPositive ? AppColors.success : AppColors.danger,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
