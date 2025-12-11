import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/client_classifications.dart';
import '../../../core/widgets/speed_dial_fab.dart';
import '../../../core/widgets/app_card.dart';
import '../../customers/presentation/customer_form_screen.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import '../../../core/services/sync_service.dart';
import '../../../core/widgets/phone_selector_dialog.dart';
import '../../../core/extensions/client_extensions.dart';
import 'client_employees_screen.dart';
import 'client_employee_form_dialog.dart';
import 'all_employees_list_screen.dart';

class ClientsListScreen extends ConsumerStatefulWidget {
  const ClientsListScreen({super.key});

  @override
  ConsumerState<ClientsListScreen> createState() => _ClientsListScreenState();
}

class _ClientsListScreenState extends ConsumerState<ClientsListScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'الكل';
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        setState(() {
          _selectedFilter = 'الكل'; // Reset filter when changing tabs
        });
      } else {
        setState(() {}); // Rebuild to update FAB
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 140.0,
              floating: false,
              pinned: true,
              backgroundColor: AppColors.jabaliBlue,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        AppColors.jabaliBlue,
                        Color(0xFF1A237E), // Darker shade
                      ],
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        right: -50,
                        top: -50,
                        child: Icon(
                          Icons.circle,
                          size: 200,
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                      Positioned(
                        left: -30,
                        bottom: -30,
                        child: Icon(
                          Icons.circle,
                          size: 150,
                          color: Colors.white.withValues(alpha: 0.05),
                        ),
                      ),
                    ],
                  ),
                ),
                title: const Text(
                  'إدارة العملاء',
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                centerTitle: true,
              ),
              leading: IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            SliverPersistentHeader(
              delegate: _SliverAppBarDelegate(
                minHeight: 190,
                maxHeight: 190,
                child: Container(
                  color: AppColors.background,
                  child: Column(
                    children: [
                      const SizedBox(height: 16),
                      // Search Bar
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Container(
                          height: 50,
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
                          child: TextField(
                            onChanged: (value) =>
                                setState(() => _searchQuery = value),
                            style: Theme.of(context).textTheme.bodyMedium,
                            decoration: InputDecoration(
                              hintText: 'بحث باسم التاجر أو المنطقة...',
                              hintStyle: TextStyle(
                                color: Theme.of(context).hintColor,
                              ),
                              prefixIcon: Icon(
                                Icons.search,
                                color: Theme.of(context).hintColor,
                              ),
                              suffixIcon: _searchQuery.isNotEmpty
                                  ? IconButton(
                                      icon: const Icon(
                                        Icons.clear,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () =>
                                          setState(() => _searchQuery = ''),
                                    )
                                  : null,
                              border: InputBorder.none,
                              contentPadding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 14,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Tabs
                      Container(
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 16),
                        child: TabBar(
                          controller: _tabController,
                          indicatorSize: TabBarIndicatorSize.tab,
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.jabaliBlue,
                          ),
                          labelColor: Colors.white,
                          unselectedLabelColor: Colors.grey,
                          dividerColor: Colors.transparent,
                          tabs: const [
                            Tab(text: 'العملاء'),
                            Tab(text: 'الوكلاء'),
                            Tab(text: 'الموظفين'),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Filter Chips
                      _buildFilterChips(),
                    ],
                  ),
                ),
              ),
              pinned: true,
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildClientsList(isAgent: false),
            _buildClientsList(isAgent: true),
            const AllEmployeesListScreen(),
          ],
        ),
      ),
      floatingActionButton: _buildFab(),
    );
  }

  Widget _buildFab() {
    return SpeedDialFAB(
      children: [
        SpeedDialChild(
          label: 'إضافة تاجر',
          icon: Icons.store,
          backgroundColor: AppColors.jabaliBlue,
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CustomerFormScreen(clientType: 'client'),
              ),
            );
          },
        ),
        SpeedDialChild(
          label: 'إضافة موظف لعميل',
          icon: Icons.person_add,
          backgroundColor: Colors.teal,
          onTap: () async {
            await showDialog(
              context: context,
              builder: (_) => const ClientEmployeeFormDialog(),
            );
          },
        ),
        SpeedDialChild(
          label: 'إضافة وكيل',
          icon: Icons.business,
          backgroundColor: AppColors.jabaliGold,
          onTap: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const CustomerFormScreen(clientType: 'agent'),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildFilterChips() {
    List<String> filters = ['الكل', ...ClientClassifications.types];

    return Container(
      height: 40,
      margin: const EdgeInsets.only(bottom: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
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
              backgroundColor: Colors.white,
              selectedColor: AppColors.jabaliBlue,
              checkmarkColor: Colors.white,
              labelStyle: TextStyle(
                color: isSelected
                    ? Colors.white
                    : Theme.of(context).textTheme.bodyMedium?.color,
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                fontSize: 12,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? AppColors.jabaliBlue
                      : Colors.grey.shade300,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClientsList({required bool isAgent}) {
    final clientsAsync = ref.watch(
      filteredClientsProvider(
        ClientFilter(query: _searchQuery, category: _selectedFilter),
      ),
    );

    return clientsAsync.when(
      data: (clients) {
        final filtered = clients.where((c) => c.isAgent == isAgent).toList();

        if (filtered.isEmpty) {
          return _buildEmptyState(isAgent ? 'لا يوجد وكلاء' : 'لا يوجد عملاء');
        }
        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildAnimatedClientCard(filtered[index], index);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildAnimatedClientCard(Client client, int index) {
    return TweenAnimationBuilder<double>(
      duration: const Duration(milliseconds: 400),
      tween: Tween(begin: 0.0, end: 1.0),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: _buildClientCard(client),
    );
  }

  Widget _buildClientCard(Client client) {
    Color importanceColor;
    final importance = client.importance ?? 'C';
    switch (importance) {
      case 'A':
        importanceColor = AppColors.success;
        break;
      case 'B':
        importanceColor = AppColors.warning;
        break;
      default:
        importanceColor = AppColors.danger;
    }

    final daysSinceVisit = DateTime.now().difference(client.updatedAt).inDays;
    final typeName = client.category ?? 'غير محدد';

    return Hero(
      tag: 'client_card_${client.id}',
      child: Material(
        color: Colors.transparent,
        child: AppCard(
          onTap: () {
            context.push('/client-details/${client.id}');
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: client.isAgent
                            ? [
                                AppColors.jabaliGold.withValues(alpha: 0.2),
                                AppColors.jabaliGold.withValues(alpha: 0.05),
                              ]
                            : [
                                AppColors.jabaliBlue.withValues(alpha: 0.2),
                                AppColors.jabaliBlue.withValues(alpha: 0.05),
                              ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      client.isAgent ? Icons.business : Icons.store,
                      color: client.isAgent
                          ? AppColors.jabaliGold
                          : AppColors.jabaliBlue,
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          client.name,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Theme.of(
                                  context,
                                ).dividerColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                typeName,
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: importanceColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  color: importanceColor.withValues(alpha: 0.5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                importance,
                                style: TextStyle(
                                  fontSize: 12,
                                  color: importanceColor,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    size: 16,
                    color: Theme.of(context).hintColor,
                  ),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      client.address ?? 'لا يوجد عنوان',
                      style: TextStyle(
                        fontSize: 13,
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_time,
                          size: 16,
                          color: Theme.of(context).hintColor,
                        ),
                        const SizedBox(width: 4),
                        Flexible(
                          child: Text(
                            'آخر زيارة: منذ $daysSinceVisit ${daysSinceVisit == 1 ? 'يوم' : 'أيام'}',
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(context).hintColor,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () =>
                        context.push('/client-details/${client.id}'),
                    icon: const Icon(Icons.arrow_forward, size: 16),
                    label: const Text('التفاصيل'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppColors.jabaliBlue,
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                    ),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                children: [
                  if (client.shopPhoneNumbers.isNotEmpty) ...[
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          PhoneSelectorDialog.show(
                            context,
                            client.shopPhoneNumbers,
                          );
                        },
                        icon: const Icon(Icons.phone, size: 18),
                        label: const Text('اتصال'),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: AppColors.jabaliBlue,
                          side: const BorderSide(color: AppColors.jabaliBlue),
                          padding: const EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                  ],
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ClientEmployeesScreen(
                              clientId: client.id,
                              clientName: client.name,
                            ),
                          ),
                        );
                      },
                      icon: const Icon(Icons.people, size: 18),
                      label: const Text('الموظفين'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.jabaliBlue,
                        side: const BorderSide(color: AppColors.jabaliBlue),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 80, color: Colors.grey.shade400),
          const SizedBox(height: 16),
          Text(
            message,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () async {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('جاري تحديث البيانات...'),
                  duration: Duration(seconds: 1),
                ),
              );
              await ref.read(syncServiceProvider).syncAll();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('تحديث البيانات'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.jabaliBlue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  _SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  double get minExtent => minHeight;

  @override
  double get maxExtent => maxHeight;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return SizedBox.expand(child: child);
  }

  @override
  bool shouldRebuild(_SliverAppBarDelegate oldDelegate) {
    return maxHeight != oldDelegate.maxHeight ||
        minHeight != oldDelegate.minHeight ||
        child != oldDelegate.child;
  }
}
