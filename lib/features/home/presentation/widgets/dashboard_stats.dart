import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class DashboardStats extends StatelessWidget {
  const DashboardStats({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        children: [
          _buildStatCard(
            title: 'مهامي اليوم',
            value: '12',
            icon: Icons.assignment_turned_in,
            color: AppColors.primary,
            gradient: [const Color(0xFF1E3A8A), const Color(0xFF3B82F6)],
          ),
          _buildStatCard(
            title: 'عهدتي',
            value: '5,000',
            currency: 'ر.ي',
            icon: Icons.inventory_2,
            color: AppColors.warning,
            gradient: [const Color(0xFFD97706), const Color(0xFFFBBF24)],
          ),
          _buildStatCard(
            title: 'تقارير معلقة',
            value: '2',
            icon: Icons.upload_file,
            color: AppColors.danger,
            gradient: [const Color(0xFFB91C1C), const Color(0xFFEF4444)],
          ),
          _buildStatCard(
            title: 'مناطق التغطية',
            value: '3',
            icon: Icons.map,
            color: AppColors.success,
            gradient: [const Color(0xFF15803D), const Color(0xFF22C55E)],
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    String? currency,
    required IconData icon,
    required Color color,
    required List<Color> gradient,
  }) {
    return Container(
      width: 150,
      margin: const EdgeInsets.only(left: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: [
                  Text(
                    value,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  if (currency != null) ...[
                    const SizedBox(width: 4),
                    Text(
                      currency,
                      style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ],
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
