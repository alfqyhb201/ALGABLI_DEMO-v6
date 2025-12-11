import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import 'client_employee_form_dialog.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  final EmployeeWithClient employeeWithClient;

  const EmployeeDetailsScreen({super.key, required this.employeeWithClient});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final employee = employeeWithClient.employee;
    final client = employeeWithClient.client;
    final previousClient = employeeWithClient.previousClient;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, employee),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('معلومات التواصل'),
                  const SizedBox(height: 12),
                  _buildContactCard(employee),
                  const SizedBox(height: 24),
                  _buildSectionHeader('معلومات العمل'),
                  const SizedBox(height: 12),
                  _buildWorkCard(context, client, previousClient),
                  if (employee.notes != null && employee.notes!.isNotEmpty) ...[
                    const SizedBox(height: 24),
                    _buildSectionHeader('ملاحظات'),
                    const SizedBox(height: 12),
                    _buildNotesCard(employee.notes!),
                  ],
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSliverAppBar(BuildContext context, ClientEmployee employee) {
    return SliverAppBar(
      expandedHeight: 220,
      pinned: true,
      backgroundColor: AppColors.jabaliBlue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.white),
        onPressed: () => Navigator.pop(context),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(12),
          ),
          child: IconButton(
            icon: const Icon(Icons.edit, color: Colors.white, size: 20),
            onPressed: () {
              showDialog(
                context: context,
                builder: (_) => ClientEmployeeFormDialog(
                  employeeToEdit: employee,
                  clientId: employee.clientId,
                ),
              );
            },
          ),
        ),
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Gradient Background
            Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColors.jabaliBlue, Color(0xFF1A237E)],
                ),
              ),
            ),
            // Decorative Circles
            Positioned(
              top: -50,
              right: -50,
              child: CircleAvatar(
                radius: 100,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            Positioned(
              bottom: -20,
              left: -20,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withValues(alpha: 0.05),
              ),
            ),
            // Content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 40),
                  Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: CircleAvatar(
                      radius: 40,
                      backgroundColor: Colors.white,
                      child: Text(
                        employee.name.isNotEmpty
                            ? employee.name[0].toUpperCase()
                            : '?',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: AppColors.jabaliBlue,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    employee.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  if (employee.role != null) ...[
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: Colors.white.withValues(alpha: 0.3),
                        ),
                      ),
                      child: Text(
                        employee.role!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 20,
          decoration: BoxDecoration(
            color: AppColors.jabaliBlue,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }

  Widget _buildContactCard(ClientEmployee employee) {
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
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.phone_outlined,
            title: 'رقم الهاتف',
            value: employee.phone ?? 'غير متوفر',
            onTap: employee.phone != null
                ? () => launchUrl(Uri.parse('tel:${employee.phone}'))
                : null,
            showDivider: employee.isDecisionMaker,
          ),
          if (employee.isDecisionMaker)
            _buildListTile(
              icon: Icons.star_outline,
              title: 'الحالة',
              value: 'صانع قرار',
              valueColor: AppColors.jabaliGold,
              iconColor: AppColors.jabaliGold,
              showDivider: false,
            ),
        ],
      ),
    );
  }

  Widget _buildWorkCard(
    BuildContext context,
    Client? client,
    Client? previousClient,
  ) {
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
      child: Column(
        children: [
          _buildListTile(
            icon: Icons.store_outlined,
            title: 'العميل الحالي',
            value: client?.name ?? 'غير محدد',
            subtitle: client?.address,
            onTap: client != null
                ? () => context.push('/client-details/${client.id}')
                : null,
            isLink: true,
            showDivider: previousClient != null,
          ),
          if (previousClient != null)
            _buildListTile(
              icon: Icons.history,
              title: 'العميل السابق',
              value: previousClient.name,
              subtitle: 'كان يعمل هنا سابقاً',
              onTap: () => context.push('/client-details/${previousClient.id}'),
              isLink: true,
              iconColor: Colors.grey,
              showDivider: false,
            ),
        ],
      ),
    );
  }

  Widget _buildNotesCard(String notes) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFF8E1), // Light yellow for notes
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: const Color(0xFFFFE082).withValues(alpha: 0.5),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                Icons.sticky_note_2_outlined,
                size: 18,
                color: Colors.orange.shade700,
              ),
              const SizedBox(width: 8),
              Text(
                'ملاحظة',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            notes,
            style: const TextStyle(
              fontSize: 14,
              height: 1.5,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({
    required IconData icon,
    required String title,
    required String value,
    String? subtitle,
    VoidCallback? onTap,
    bool isLink = false,
    Color? iconColor,
    Color? valueColor,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(16),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppColors.jabaliBlue).withValues(
                        alpha: 0.1,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      icon,
                      color: iconColor ?? AppColors.jabaliBlue,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          value,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color:
                                valueColor ??
                                (isLink
                                    ? AppColors.jabaliBlue
                                    : AppColors.textPrimary),
                          ),
                        ),
                        if (subtitle != null) ...[
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  if (onTap != null)
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey.shade400,
                    ),
                ],
              ),
            ),
          ),
        ),
        if (showDivider)
          Padding(
            padding: const EdgeInsets.only(right: 60),
            child: Divider(height: 1, color: Colors.grey.shade100),
          ),
      ],
    );
  }
}
