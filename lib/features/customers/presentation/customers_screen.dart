import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import 'package:intl/intl.dart' as intl;

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  String _selectedFilter = 'الكل';
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(
      filteredClientsProvider(
        ClientFilter(query: _searchQuery, category: _selectedFilter),
      ),
    );

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(title: const Text('قائمة العملاء')),
      body: Column(
        children: [
          _buildSearchBar(),
          _buildFilterChips(),
          Expanded(
            child: clientsAsync.when(
              data: (clients) {
                if (clients.isEmpty) {
                  return const Center(child: Text('لا توجد نتائج'));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: clients.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    return _buildCustomerCard(clients[index]);
                  },
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (err, stack) => Center(child: Text('حدث خطأ: $err')),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          context.push('/customer-form');
        },
        backgroundColor: AppColors.jabaliRed,
        icon: const Icon(Icons.add),
        label: const Text('إضافة عميل'),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: TextField(
        onChanged: (value) => setState(() => _searchQuery = value),
        decoration: InputDecoration(
          hintText: 'بحث باسم العميل أو المنطقة...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey.shade100,
        ),
      ),
    );
  }

  Widget _buildFilterChips() {
    final filters = [
      'الكل',
      'تاجر دراجات نارية',
      'تاجر قطع غيار',
      'تاجر زيوت',
      'متجر متخصص',
      'تاجر جملة',
      'ورشة / ميكانيكي',
    ];

    return Container(
      height: 60,
      color: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter;

          return Padding(
            padding: const EdgeInsets.only(left: 8),
            child: FilterChip(
              label: Text(filter),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedFilter = filter);
              },
              backgroundColor: Colors.grey.shade100,
              selectedColor: AppColors.jabaliBlue.withValues(alpha: 0.2),
              labelStyle: TextStyle(
                color: isSelected ? AppColors.jabaliBlue : Colors.black87,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildCustomerCard(Client client) {
    final dateFormat = intl.DateFormat('d MMM yyyy', 'ar');

    Color loyaltyColor;
    switch (client.loyaltyLevel) {
      case 'high':
        loyaltyColor = AppColors.success;
        break;
      case 'medium':
        loyaltyColor = AppColors.warning;
        break;
      default:
        loyaltyColor = AppColors.danger;
    }

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Navigate to customer details
          // context.push('/customer-details', extra: client);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.store, color: AppColors.jabaliBlue),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.name,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            if (client.category != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  client.category!,
                                  style: const TextStyle(fontSize: 11),
                                ),
                              ),
                            const SizedBox(width: 8),
                            if (client.importance != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: loyaltyColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  client.importance!,
                                  style: TextStyle(
                                    fontSize: 11,
                                    color: loyaltyColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.phone, color: AppColors.jabaliBlue),
                    onPressed: () async {
                      if (client.phone != null && client.phone!.isNotEmpty) {
                        final phoneNumber = client.phone!.first;
                        final Uri launchUri = Uri(
                          scheme: 'tel',
                          path: phoneNumber,
                        );
                        if (await canLaunchUrl(launchUri)) {
                          await launchUrl(launchUri);
                        } else {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('لا يمكن إجراء المكالمة'),
                              ),
                            );
                          }
                        }
                      } else {
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('لا يوجد رقم هاتف لهذا العميل'),
                            ),
                          );
                        }
                      }
                    },
                  ),
                ],
              ),
              const SizedBox(height: 12),
              if (client.address != null)
                Row(
                  children: [
                    const Icon(
                      Icons.location_on_outlined,
                      size: 16,
                      color: Colors.grey,
                    ),
                    const SizedBox(width: 4),
                    Expanded(
                      child: Text(
                        client.address!,
                        style: const TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8),
              if (client.lastVisit != null)
                Row(
                  children: [
                    const Icon(Icons.access_time, size: 16, color: Colors.grey),
                    const SizedBox(width: 4),
                    Text(
                      'آخر زيارة: ${dateFormat.format(client.lastVisit!)}',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ),
    );
  }
}
