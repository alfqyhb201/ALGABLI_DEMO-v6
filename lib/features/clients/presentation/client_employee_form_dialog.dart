import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';

class ClientEmployeeFormDialog extends ConsumerStatefulWidget {
  final int? clientId;
  final ClientEmployee? employeeToEdit;

  const ClientEmployeeFormDialog({
    super.key,
    this.clientId,
    this.employeeToEdit,
  });

  @override
  ConsumerState<ClientEmployeeFormDialog> createState() =>
      _ClientEmployeeFormDialogState();
}

class _ClientEmployeeFormDialogState
    extends ConsumerState<ClientEmployeeFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _roleController;
  late TextEditingController _notesController;
  bool _isDecisionMaker = false;
  int? _selectedClientId;
  String? _selectedRole;
  bool _isCustomRole = false;

  final List<String> _suggestedRoles = [
    'مهندس',
    'مدير مشتريات',
    'مدير علاقات',
    'فني صيانة',
    'محاسب',
    'مدير فرع',
    'أخرى',
  ];

  @override
  void initState() {
    super.initState();
    final employee = widget.employeeToEdit;
    _nameController = TextEditingController(text: employee?.name ?? '');
    _phoneController = TextEditingController(text: employee?.phone ?? '');
    _roleController = TextEditingController(text: employee?.role ?? '');
    _notesController = TextEditingController(text: employee?.notes ?? '');
    _isDecisionMaker = employee?.isDecisionMaker ?? false;
    _selectedClientId = widget.clientId ?? employee?.clientId;

    if (employee?.role != null && employee!.role!.isNotEmpty) {
      if (_suggestedRoles.contains(employee.role)) {
        _selectedRole = employee.role;
      } else {
        _selectedRole = 'أخرى';
        _isCustomRole = true;
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _roleController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.employeeToEdit != null;

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      backgroundColor: Colors.white,
      elevation: 0,
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(maxWidth: 400),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        isEditing ? Icons.edit : Icons.person_add,
                        color: AppColors.jabaliBlue,
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Text(
                        isEditing ? 'تعديل بيانات الموظف' : 'إضافة موظف جديد',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Client Selector
                if (_selectedClientId == null || isEditing) ...[
                  _buildClientSelector(),
                  const SizedBox(height: 16),
                ],

                // Name Field
                _buildTextField(
                  controller: _nameController,
                  label: 'الاسم',
                  icon: Icons.person_outline,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال الاسم';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Phone Field
                _buildTextField(
                  controller: _phoneController,
                  label: 'رقم الهاتف',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.number,
                  maxLength: 9,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      if (value.length != 9) {
                        return 'يجب أن يتكون الرقم من 9 أرقام';
                      }
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Role Dropdown
                DropdownButtonFormField<String>(
                  value: _selectedRole,
                  decoration: InputDecoration(
                    labelText: 'المسمى الوظيفي',
                    prefixIcon: Icon(
                      Icons.work_outline,
                      color: Colors.grey.shade400,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Colors.grey.shade50,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey.shade200),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(color: AppColors.jabaliBlue),
                    ),
                    contentPadding: const EdgeInsets.all(16),
                  ),
                  items: _suggestedRoles.map((role) {
                    return DropdownMenuItem(value: role, child: Text(role));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedRole = value;
                      if (value == 'أخرى') {
                        _isCustomRole = true;
                        _roleController.clear();
                      } else {
                        _isCustomRole = false;
                        _roleController.text = value ?? '';
                      }
                    });
                  },
                ),
                if (_isCustomRole) ...[
                  const SizedBox(height: 12),
                  _buildTextField(
                    controller: _roleController,
                    label: 'أدخل المسمى الوظيفي',
                    icon: Icons.edit_outlined,
                    validator: (value) {
                      if (_isCustomRole && (value == null || value.isEmpty)) {
                        return 'يرجى إدخال المسمى الوظيفي';
                      }
                      return null;
                    },
                  ),
                ],
                const SizedBox(height: 16),

                // Decision Maker Toggle
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: _isDecisionMaker
                        ? AppColors.jabaliGold.withValues(alpha: 0.1)
                        : Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: _isDecisionMaker
                          ? AppColors.jabaliGold
                          : Colors.grey.shade200,
                    ),
                  ),
                  child: SwitchListTile(
                    title: const Text(
                      'صانع قرار؟',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: const Text(
                      'هل يملك صلاحية اتخاذ القرارات؟',
                      style: TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    value: _isDecisionMaker,
                    onChanged: (value) =>
                        setState(() => _isDecisionMaker = value),
                    activeColor: AppColors.jabaliGold,
                    contentPadding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Notes Field
                _buildTextField(
                  controller: _notesController,
                  label: 'ملاحظات',
                  icon: Icons.sticky_note_2_outlined,
                  maxLines: 3,
                ),
                const SizedBox(height: 32),

                // Action Buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'إلغاء',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      flex: 2,
                      child: ElevatedButton(
                        onPressed: _save,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.jabaliBlue,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        child: Text(
                          isEditing ? 'حفظ التغييرات' : 'إضافة الموظف',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
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
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    String? hint,
    TextInputType? keyboardType,
    int maxLines = 1,
    int? maxLength,
    List<TextInputFormatter>? inputFormatters,
    String? Function(String?)? validator,
    FocusNode? focusNode,
    void Function(String)? onChanged,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: keyboardType,
      maxLines: maxLines,
      maxLength: maxLength,
      inputFormatters: inputFormatters,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
        filled: true,
        fillColor: Colors.grey.shade50,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey.shade200),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.jabaliBlue),
        ),
        contentPadding: const EdgeInsets.all(16),
        counterText: "", // Hide character counter
      ),
    );
  }

  Widget _buildClientSelector() {
    final clientsAsync = ref.watch(clientsProvider);

    return clientsAsync.when(
      data: (clients) {
        String initialName = '';
        if (_selectedClientId != null) {
          try {
            initialName = clients
                .firstWhere((c) => c.id == _selectedClientId)
                .name;
          } catch (_) {}
        }

        return Autocomplete<Client>(
          initialValue: TextEditingValue(text: initialName),
          optionsBuilder: (TextEditingValue textEditingValue) {
            if (textEditingValue.text == '') {
              return const Iterable<Client>.empty();
            }
            return clients.where((Client option) {
              return option.name.toLowerCase().contains(
                textEditingValue.text.toLowerCase(),
              );
            });
          },
          displayStringForOption: (Client option) => option.name,
          onSelected: (Client selection) {
            setState(() {
              _selectedClientId = selection.id;
            });
          },
          fieldViewBuilder:
              (
                BuildContext context,
                TextEditingController fieldTextEditingController,
                FocusNode fieldFocusNode,
                VoidCallback onFieldSubmitted,
              ) {
                return _buildTextField(
                  controller: fieldTextEditingController,
                  focusNode: fieldFocusNode,
                  label: 'اختر العميل',
                  icon: Icons.store_outlined,
                  hint: 'ابحث باسم العميل...',
                  validator: (value) {
                    if (_selectedClientId == null) {
                      return 'يرجى اختيار العميل من القائمة';
                    }
                    return null;
                  },
                );
              },
        );
      },
      loading: () => Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.grey.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Center(child: CircularProgressIndicator()),
      ),
      error: (_, __) => Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.red.shade50,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Text(
          'خطأ في تحميل العملاء',
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedClientId == null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('يرجى اختيار العميل')));
        return;
      }

      final controller = ref.read(clientEmployeesControllerProvider.notifier);

      if (widget.employeeToEdit != null) {
        // Update
        final updatedEmployee = ClientEmployeesCompanion(
          id: drift.Value(widget.employeeToEdit!.id),
          clientId: drift.Value(_selectedClientId!),
          name: drift.Value(_nameController.text),
          phone: drift.Value(_phoneController.text),
          role: drift.Value(_roleController.text),
          isDecisionMaker: drift.Value(_isDecisionMaker),
          notes: drift.Value(_notesController.text),
        );
        await controller.updateEmployee(updatedEmployee);
      } else {
        // Add
        final newEmployee = ClientEmployeesCompanion(
          clientId: drift.Value(_selectedClientId!),
          name: drift.Value(_nameController.text),
          phone: drift.Value(_phoneController.text),
          role: drift.Value(_roleController.text),
          isDecisionMaker: drift.Value(_isDecisionMaker),
          notes: drift.Value(_notesController.text),
        );
        await controller.addEmployee(newEmployee);
      }

      if (mounted) Navigator.pop(context);
    }
  }
}
