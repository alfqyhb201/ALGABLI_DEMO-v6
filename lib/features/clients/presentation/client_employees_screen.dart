import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import 'client_employee_form_dialog.dart';
import 'employee_details_screen.dart';

class ClientEmployeesScreen extends ConsumerWidget {
  final int clientId;
  final String clientName;

  const ClientEmployeesScreen({
    super.key,
    required this.clientId,
    required this.clientName,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(clientEmployeesProvider(clientId));
    final clientAsync = ref.watch(clientProvider(clientId));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: employeesAsync.when(
        data: (employees) {
          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(context),
              if (employees.isEmpty)
                SliverFillRemaining(child: _buildEmptyState())
              else
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      return clientAsync.when(
                        data: (client) => _buildAnimatedEmployeeCard(
                          context,
                          index,
                          employees[index],
                          client,
                          ref,
                        ),
                        loading: () => _buildAnimatedEmployeeCard(
                          context,
                          index,
                          employees[index],
                          null,
                          ref,
                        ),
                        error: (_, __) => _buildAnimatedEmployeeCard(
                          context,
                          index,
                          employees[index],
                          null,
                          ref,
                        ),
                      );
                    }, childCount: employees.length),
                  ),
                ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) => ClientEmployeeFormDialog(clientId: clientId),
          );
        },
        label: const Text(
          'إضافة موظف',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        icon: const Icon(Icons.person_add, color: Colors.white),
        backgroundColor: AppColors.jabaliBlue,
        elevation: 4,
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 120.0,
      floating: false,
      pinned: true,
      backgroundColor: AppColors.jabaliBlue,
      flexibleSpace: FlexibleSpaceBar(
        title: Text(
          'موظفي $clientName',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
        centerTitle: true,
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppColors.jabaliBlue, Color(0xFF1A237E)],
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: -30,
                top: -30,
                child: Icon(
                  Icons.people,
                  size: 150,
                  color: Colors.white.withValues(alpha: 0.1),
                ),
              ),
            ],
          ),
        ),
      ),
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: AppColors.jabaliBlue.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.people_outline,
              size: 64,
              color: AppColors.jabaliBlue.withValues(alpha: 0.5),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'لا يوجد موظفين مضافين',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'قم بإضافة موظفين لهذا العميل لتسهيل التواصل',
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildAnimatedEmployeeCard(
    BuildContext context,
    int index,
    ClientEmployee employee,
    Client? client,
    WidgetRef ref,
  ) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeOutQuart,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 50 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: _EmployeeCard(employee: employee, client: client, ref: ref),
      ),
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final ClientEmployee employee;
  final Client? client;
  final WidgetRef ref;

  const _EmployeeCard({
    required this.employee,
    required this.client,
    required this.ref,
  });

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          onTap: () {
            if (client != null) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmployeeDetailsScreen(
                    employeeWithClient: EmployeeWithClient(
                      employee: employee,
                      client: client,
                    ),
                  ),
                ),
              );
            }
          },
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Row(
                  children: [
                    // Avatar
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.jabaliBlue, Color(0xFF1A237E)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.jabaliBlue.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          employee.name.isNotEmpty
                              ? employee.name[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Flexible(
                                child: Text(
                                  employee.name,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.textPrimary,
                                  ),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              if (employee.isDecisionMaker) ...[
                                const SizedBox(width: 8),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: AppColors.jabaliGold.withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: AppColors.jabaliGold.withValues(
                                        alpha: 0.5,
                                      ),
                                    ),
                                  ),
                                  child: const Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 10,
                                        color: AppColors.jabaliGold,
                                      ),
                                      SizedBox(width: 4),
                                      Text(
                                        'صانع قرار',
                                        style: TextStyle(
                                          fontSize: 10,
                                          color: AppColors.jabaliGold,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ],
                          ),
                          const SizedBox(height: 4),
                          if (employee.role != null &&
                              employee.role!.isNotEmpty)
                            Row(
                              children: [
                                Icon(
                                  Icons.work_outline,
                                  size: 14,
                                  color: Colors.grey.shade600,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  employee.role!,
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    // Menu
                    PopupMenuButton<String>(
                      icon: Icon(Icons.more_vert, color: Colors.grey.shade400),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Row(
                            children: [
                              Icon(
                                Icons.edit,
                                size: 20,
                                color: AppColors.jabaliBlue,
                              ),
                              SizedBox(width: 8),
                              Text('تعديل'),
                            ],
                          ),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Row(
                            children: [
                              Icon(
                                Icons.delete,
                                size: 20,
                                color: AppColors.danger,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'حذف',
                                style: TextStyle(color: AppColors.danger),
                              ),
                            ],
                          ),
                        ),
                      ],
                      onSelected: (value) {
                        if (value == 'edit') {
                          showDialog(
                            context: context,
                            builder: (context) => ClientEmployeeFormDialog(
                              clientId: employee.clientId,
                              employeeToEdit: employee,
                            ),
                          );
                        } else if (value == 'delete') {
                          _showDeleteDialog(context, ref, employee);
                        }
                      },
                    ),
                  ],
                ),
                if (employee.phone != null && employee.phone!.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextButton.icon(
                          onPressed: () => _makePhoneCall(employee.phone!),
                          icon: const Icon(
                            Icons.phone,
                            size: 18,
                            color: AppColors.jabaliBlue,
                          ),
                          label: Text(
                            employee.phone!,
                            style: const TextStyle(
                              color: AppColors.jabaliBlue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: TextButton.styleFrom(
                            backgroundColor: AppColors.jabaliBlue.withValues(
                              alpha: 0.05,
                            ),
                            padding: const EdgeInsets.symmetric(vertical: 12),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    ClientEmployee employee,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('حذف الموظف'),
        content: Text('هل أنت متأكد من حذف ${employee.name}؟'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('إلغاء'),
          ),
          TextButton(
            onPressed: () async {
              await ref
                  .read(clientEmployeesControllerProvider.notifier)
                  .deleteEmployee(employee.id);
              if (context.mounted) Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: const Text('حذف'),
          ),
        ],
      ),
    );
  }
}
