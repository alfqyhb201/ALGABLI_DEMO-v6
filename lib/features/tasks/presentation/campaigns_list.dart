import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';
import '../../../core/widgets/app_card.dart';

class CampaignsList extends ConsumerWidget {
  const CampaignsList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final campaignsAsync = ref.watch(allCampaignsProvider);

    return campaignsAsync.when(
      data: (campaigns) {
        if (campaigns.isEmpty) {
          return _buildEmptyState(context);
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: campaigns.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildCampaignCard(context, campaigns[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildCampaignCard(BuildContext context, Campaign campaign) {
    Color statusColor;
    String statusText;

    switch (campaign.status) {
      case 'active':
        statusColor = AppColors.success;
        statusText = 'نشطة';
        break;
      case 'completed':
        statusColor = AppColors.jabaliBlue;
        statusText = 'مكتملة';
        break;
      case 'draft':
      default:
        statusColor = Colors.grey;
        statusText = 'مسودة';
        break;
    }

    return AppCard(
      onTap: () {
        // Navigate to campaign details (to be implemented)
        // context.push('/campaign-details/${campaign.id}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.campaign, color: statusColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      campaign.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      campaign.campaignType,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: statusColor),
                ),
                child: Text(
                  statusText,
                  style: TextStyle(
                    color: statusColor,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          if (campaign.description != null) ...[
            Text(
              campaign.description!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Theme.of(context).textTheme.bodySmall?.color,
              ),
            ),
            const SizedBox(height: 12),
          ],
          const Divider(),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 14,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    campaign.startDate != null
                        ? _formatDate(campaign.startDate!)
                        : 'غير محدد',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              if (campaign.budget > 0)
                Text(
                  '${campaign.budget.toStringAsFixed(0)} ر.ي',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: AppColors.jabaliGold,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.campaign_outlined, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            'لا توجد حملات',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Theme.of(context).hintColor,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }
}
