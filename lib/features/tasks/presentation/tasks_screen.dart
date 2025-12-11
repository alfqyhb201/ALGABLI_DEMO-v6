import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:drift/drift.dart' hide Column;

import '../../../core/constants/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';
import '../../../core/providers/clients_provider.dart';
import '../../../core/services/auth_service.dart';
import 'campaigns_list.dart';

class TasksScreen extends ConsumerStatefulWidget {
  const TasksScreen({super.key});

  @override
  ConsumerState<TasksScreen> createState() => _TasksScreenState();
}

class _TasksScreenState extends ConsumerState<TasksScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      setState(() {}); // Rebuild to update FAB
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final isManager = user?['role'] == 'manager' || user?['role'] == 'admin';

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Dark Header Background
          Container(
            height: 240,
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
                          'إدارة المهام والحملات',
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

              const SizedBox(height: 24),

              // Tabs
              Container(
                height: 40,
                margin: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildTabItem('المهام', 0),
                    _buildTabItem('الحملات', 1),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Content
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [_buildTasksTab(), const CampaignsList()],
                ),
              ),
            ],
          ),
        ],
      ),
      floatingActionButton: _buildFab(isManager),
    );
  }

  Widget _buildFab(bool isManager) {
    // If on Tasks tab (index 0), show Add Task
    if (_tabController.index == 0) {
      return FloatingActionButton.extended(
        onPressed: () => context.push('/create-task'),
        label: const Text('مهمة جديدة'),
        icon: const Icon(Icons.add_task),
        backgroundColor: AppColors.jabaliBlue,
        foregroundColor: Colors.white,
      );
    }
    // If on Campaigns tab (index 1), show Add Campaign ONLY if manager
    else {
      if (isManager) {
        return FloatingActionButton.extended(
          onPressed: () {
            // Navigate to create campaign
            _showAddCampaignDialog(context, ref);
          },
          label: const Text('حملة جديدة'),
          icon: const Icon(Icons.campaign),
          backgroundColor: AppColors.jabaliGold,
          foregroundColor: Colors.black,
        );
      } else {
        return const SizedBox(); // Hide FAB for non-managers
      }
    }
  }

  Widget _buildTabItem(String title, int index) {
    final isSelected = _tabController.index == index;
    return GestureDetector(
      onTap: () {
        _tabController.animateTo(index);
        setState(() {});
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.background : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
          border: isSelected ? null : Border.all(color: Colors.white30),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.black : Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildTasksTab() {
    return Column(
      children: [
        // Search Bar (Floating)
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Container(
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
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
              onChanged: (value) => setState(() => _searchQuery = value),
              style: Theme.of(context).textTheme.bodyMedium,
              decoration: InputDecoration(
                hintText: 'بحث في المهام...',
                hintStyle: TextStyle(color: Theme.of(context).hintColor),
                prefixIcon: Icon(
                  Icons.search,
                  color: Theme.of(context).hintColor,
                ),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () => setState(() => _searchQuery = ''),
                      )
                    : null,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
              ),
            ),
          ),
        ),

        const SizedBox(height: 16),

        // Filter Chips (Replacing old tabs)
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _buildFilterChip('الكل', null),
              const SizedBox(width: 8),
              _buildFilterChip('قيد التنفيذ', 'in_progress'),
              const SizedBox(width: 8),
              _buildFilterChip('مكتملة', 'completed'),
              const SizedBox(width: 8),
              _buildFilterChip('مؤجلة', 'deferred'),
            ],
          ),
        ),

        const SizedBox(height: 16),

        Expanded(child: _buildTasksList(_selectedStatus)),
      ],
    );
  }

  String? _selectedStatus;

  Widget _buildFilterChip(String label, String? status) {
    final isSelected = _selectedStatus == status;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedStatus = status;
        });
      },
      backgroundColor: Theme.of(context).cardColor,
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
          color: isSelected ? AppColors.jabaliBlue : Colors.transparent,
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 0),
    );
  }

  Widget _buildTasksList(String? status) {
    // Use myTasksProvider to filter tasks by current user
    final tasksAsync = ref.watch(myTasksProvider);

    return tasksAsync.when(
      data: (tasks) {
        var filtered = tasks;

        // Filter by status
        if (status != null) {
          filtered = filtered.where((t) => t.status == status).toList();
        }

        // Filter by search query
        if (_searchQuery.isNotEmpty) {
          filtered = filtered;
          return _buildEmptyState();
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: filtered.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            return _buildTaskCard(filtered[index]);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildTaskCard(Task task) {
    Color statusColor;
    String statusText;

    switch (task.status) {
      case 'completed':
        statusColor = AppColors.success;
        statusText = 'مكتملة';
        break;
      case 'in_progress':
        statusColor = AppColors.warning;
        statusText = 'قيد التنفيذ';
        break;
      case 'deferred':
        statusColor = AppColors.danger;
        statusText = 'مؤجلة';
        break;
      case 'pending':
      default:
        statusColor = Colors.grey;
        statusText = 'قيد الانتظار';
        break;
    }

    return AppCard(
      onTap: () => context.push('/task-details/${task.id}'),
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
                child: Icon(Icons.task_alt, color: statusColor, size: 24),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      task.title,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    if (task.clientId != null)
                      Consumer(
                        builder: (context, ref, child) {
                          final clientAsync = ref.watch(
                            clientProvider(task.clientId!),
                          );
                          return clientAsync.when(
                            data: (client) => Text(
                              client.name,
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                            loading: () => const SizedBox(),
                            error: (_, __) => const SizedBox(),
                          );
                        },
                      )
                    else
                      Text(
                        'عميل غير محدد',
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
          Text(
            task.description ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          ),
          const SizedBox(height: 12),
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
                    task.dueAt != null ? _formatDate(task.dueAt!) : 'غير محدد',
                    style: TextStyle(
                      fontSize: 12,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              if (task.priority == 'high')
                const Row(
                  children: [
                    Icon(Icons.flag, size: 14, color: AppColors.danger),
                    SizedBox(width: 4),
                    Text(
                      'أولوية عالية',
                      style: TextStyle(fontSize: 12, color: AppColors.danger),
                    ),
                  ],
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.assignment_outlined,
            size: 80,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'لا توجد مهام',
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

  void _showAddCampaignDialog(BuildContext context, WidgetRef ref) {
    final titleController = TextEditingController();
    final descriptionController = TextEditingController();
    final typeController = TextEditingController();
    final budgetController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('إضافة حملة جديدة'),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: titleController,
                decoration: const InputDecoration(labelText: 'عنوان الحملة'),
              ),
              TextField(
                controller: descriptionController,
                decoration: const InputDecoration(labelText: 'الوصف'),
              ),
              TextField(
                controller: typeController,
                decoration: const InputDecoration(
                  labelText: 'النوع (email, sms, etc.)',
                ),
              ),
              TextField(
                controller: budgetController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'الميزانية'),
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              if (titleController.text.isNotEmpty) {
                final campaign = CampaignsCompanion(
                  title: Value(titleController.text),
                  description: Value(descriptionController.text),
                  campaignType: Value(
                    typeController.text.isEmpty
                        ? 'general'
                        : typeController.text,
                  ),
                  budget: Value(double.tryParse(budgetController.text) ?? 0.0),
                  startDate: Value(DateTime.now()),
                  endDate: Value(DateTime.now().add(const Duration(days: 30))),
                  status: const Value('active'),
                );
                await ref
                    .read(campaignsControllerProvider)
                    .addCampaign(campaign);
                if (context.mounted) Navigator.pop(context);
              }
            },
            child: const Text('إضافة'),
          ),
        ],
      ),
    );
  }
}
