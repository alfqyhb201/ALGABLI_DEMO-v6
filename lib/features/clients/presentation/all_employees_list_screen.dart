import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/providers/clients_provider.dart';
import 'client_employee_form_dialog.dart';
import 'employee_details_screen.dart';
import '../../../core/database/app_database.dart';

class AllEmployeesListScreen extends ConsumerWidget {
  const AllEmployeesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employeesAsync = ref.watch(allEmployeesProvider);

    return employeesAsync.when(
      data: (employees) {
        if (employees.isEmpty) {
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
                  'لا يوجد موظفين',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          );
        }

        return ListView.separated(
          padding: const EdgeInsets.all(16),
          itemCount: employees.length,
          separatorBuilder: (context, index) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final item = employees[index];
            return _buildAnimatedEmployeeCard(context, index, item, ref);
          },
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(child: Text('Error: $error')),
    );
  }

  Widget _buildAnimatedEmployeeCard(
    BuildContext context,
    int index,
    EmployeeWithClient item,
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
      child: _EmployeeCard(item: item, ref: ref),
    );
  }
}

class _EmployeeCard extends StatelessWidget {
  final EmployeeWithClient item;
  final WidgetRef ref;

  const _EmployeeCard({required this.item, required this.ref});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    }
  }

  @override
  Widget build(BuildContext context) {
    final employee = item.employee;
    final client = item.client;

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
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => EmployeeDetailsScreen(employeeWithClient: item),
              ),
            );
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
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.store,
                                size: 14,
                                color: AppColors.jabaliBlue,
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  client?.name ?? 'غير محدد',
                                  style: const TextStyle(
                                    color: AppColors.jabaliBlue,
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  overflow: TextOverflow.ellipsis,
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
                        // Note: Delete might require more context or confirmation in this view
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
}
