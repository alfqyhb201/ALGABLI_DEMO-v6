import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/reports_provider.dart';

class ReportsScreen extends ConsumerWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final reportsAsync = ref.watch(reportsProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Dark Header Background
          Container(
            height: 180,
            decoration: const BoxDecoration(
              color: AppColors.jabaliBlue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
            ),
          ),

          Column(
            children: [
              // Custom AppBar
              SafeArea(
                bottom: false,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.menu, color: Colors.white),
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                      ),
                      const Expanded(
                        child: Text(
                          'التقارير والإحصائيات',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 48), // Balance for menu icon
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 16),

              // Content
              Expanded(
                child: reportsAsync.when(
                  data: (data) => SingleChildScrollView(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildPerformanceSummary(context, data),
                        const SizedBox(height: 24),
                        Text(
                          'الأداء الأسبوعي',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildWeeklyChart(context, data.weeklyVisits),
                        const SizedBox(height: 24),
                        Text(
                          'إحصائيات العملاء',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        _buildCustomerStats(context, data.clientsByCategory),
                      ],
                    ),
                  ),
                  loading: () =>
                      const Center(child: CircularProgressIndicator()),
                  error: (err, stack) => Center(child: Text('حدث خطأ: $err')),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPerformanceSummary(BuildContext context, ReportsData data) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'ملخص الأداء الشهري',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'العملاء',
                  data.totalClients.toString(),
                  Icons.people,
                  AppColors.jabaliBlue,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  'العملاء الجدد',
                  data.newClients.toString(),
                  Icons.person_add,
                  AppColors.success,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  context,
                  'التقارير',
                  data.totalReports.toString(),
                  Icons.description,
                  AppColors.warning,
                ),
              ),
              Expanded(
                child: _buildStatItem(
                  context,
                  'نسبة الإنجاز',
                  '${(data.completionRate * 100).toStringAsFixed(0)}%',
                  Icons.trending_up,
                  AppColors.jabaliRed,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    IconData icon,
    Color color,
  ) {
    return Column(
      children: [
        Icon(icon, color: color, size: 32),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }

  Widget _buildWeeklyChart(BuildContext context, List<int> visits) {
    // Map visits (last 7 days) to days of week.
    // Assuming visits[6] is today, visits[5] is yesterday, etc.
    final now = DateTime.now();
    final days = List.generate(7, (index) {
      final date = now.subtract(Duration(days: 6 - index));
      // Simple day name mapping (Arabic)
      const dayNames = [
        'الإثنين',
        'الثلاثاء',
        'الأربعاء',
        'الخميس',
        'الجمعة',
        'السبت',
        'الأحد',
      ];
      return dayNames[date.weekday - 1]; // weekday is 1..7 (Mon..Sun)
    });

    final maxVisits = visits.reduce((curr, next) => curr > next ? curr : next);
    final maxY = maxVisits > 0 ? maxVisits : 10;

    return AppCard(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(7, (index) {
              return _buildBar(context, days[index], visits[index], maxY);
            }),
          ),
          const SizedBox(height: 16),
          Text(
            'عدد الزيارات اليومية (آخر 7 أيام)',
            style: Theme.of(context).textTheme.bodySmall,
          ),
        ],
      ),
    );
  }

  Widget _buildBar(BuildContext context, String day, int value, int max) {
    final height = max > 0 ? (value / max) * 100.0 : 0.0;
    return Column(
      children: [
        Container(
          width: 30,
          height: 100,
          alignment: Alignment.bottomCenter,
          child: Container(
            width: 30,
            height: height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.jabaliBlue.withValues(alpha: 0.7),
                  AppColors.jabaliBlue,
                ],
              ),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          day,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildCustomerStats(BuildContext context, Map<String, int> stats) {
    if (stats.isEmpty) {
      return const Center(child: Text('لا توجد بيانات'));
    }

    final total = stats.values.fold(0, (sum, count) => sum + count);
    final colors = [
      AppColors.jabaliBlue,
      AppColors.success,
      AppColors.warning,
      AppColors.jabaliRed,
      Colors.purple,
      Colors.orange,
    ];

    int colorIndex = 0;
    return AppCard(
      child: Column(
        children: stats.entries.map((entry) {
          final color = colors[colorIndex % colors.length];
          colorIndex++;
          return Column(
            children: [
              _buildCustomerStatRow(
                context,
                entry.key,
                entry.value,
                total,
                color,
              ),
              const SizedBox(height: 12),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCustomerStatRow(
    BuildContext context,
    String type,
    int count,
    int total,
    Color color,
  ) {
    return Row(
      children: [
        Expanded(
          flex: 2,
          child: Text(
            type,
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          flex: 5,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: total > 0 ? count / total : 0,
              backgroundColor: Theme.of(
                context,
              ).dividerColor.withValues(alpha: 0.2),
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 8,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          count.toString(),
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
