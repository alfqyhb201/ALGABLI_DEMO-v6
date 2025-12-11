import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:drift/drift.dart' as drift;
import '../../../core/constants/app_colors.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/tasks_provider.dart';
import '../../../core/providers/clients_provider.dart';
import '../../employees/presentation/client_selector_sheet.dart';

class CreateTaskScreen extends ConsumerStatefulWidget {
  const CreateTaskScreen({super.key});

  @override
  ConsumerState<CreateTaskScreen> createState() => _CreateTaskScreenState();
}

class _CreateTaskScreenState extends ConsumerState<CreateTaskScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _dueDate = DateTime.now().add(const Duration(days: 1));
  TimeOfDay _dueTime = const TimeOfDay(hour: 9, minute: 0);
  String _priority = 'medium';
  int? _selectedClientId;
  int? _selectedCampaignId;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _dueDate) {
      setState(() => _dueDate = picked);
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _dueTime,
    );
    if (picked != null && picked != _dueTime) {
      setState(() => _dueTime = picked);
    }
  }

  void _showClientSelector(BuildContext context, List<Client> clients) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        minChildSize: 0.5,
        maxChildSize: 0.9,
        expand: false,
        builder: (context, scrollController) {
          return ClientSelectorSheet(
            clients: clients,
            onSelect: (client) {
              setState(() => _selectedClientId = client.id);
              Navigator.pop(context);
            },
          );
        },
      ),
    );
  }

  void _saveTask() async {
    if (_formKey.currentState!.validate()) {
      final dueDateTime = DateTime(
        _dueDate.year,
        _dueDate.month,
        _dueDate.day,
        _dueTime.hour,
        _dueTime.minute,
      );

      final task = TasksCompanion(
        title: drift.Value(_titleController.text),
        description: drift.Value(
          _descriptionController.text.isEmpty
              ? null
              : _descriptionController.text,
        ),
        dueAt: drift.Value(dueDateTime),
        priority: drift.Value(_priority),
        clientId: drift.Value(_selectedClientId),
        campaignId: drift.Value(_selectedCampaignId),
        status: const drift.Value('pending'),
        progressPercentage: const drift.Value(0),
      );

      await ref.read(tasksControllerProvider).addTask(task);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('تم إضافة المهمة بنجاح')));
        context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final clientsAsync = ref.watch(clientsProvider);
    final campaignsAsync = ref.watch(allCampaignsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('مهمة جديدة'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () => context.pop(),
        ),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            _buildSectionTitle('تفاصيل المهمة'),
            const SizedBox(height: 16),
            TextFormField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'عنوان المهمة',
                prefixIcon: const Icon(Icons.title),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              validator: (value) => value == null || value.isEmpty
                  ? 'الرجاء إدخال عنوان المهمة'
                  : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'الوصف',
                prefixIcon: const Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('الموعد والأولوية'),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () => _selectDate(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'التاريخ',
                        prefixIcon: const Icon(Icons.calendar_today),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      child: Text(DateFormat('yyyy-MM-dd').format(_dueDate)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: InkWell(
                    onTap: () => _selectTime(context),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: 'الوقت',
                        prefixIcon: const Icon(Icons.access_time),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      child: Text(_dueTime.format(context)),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _priority,
              decoration: InputDecoration(
                labelText: 'الأولوية',
                prefixIcon: const Icon(Icons.flag),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              items: const [
                DropdownMenuItem(value: 'low', child: Text('منخفضة')),
                DropdownMenuItem(value: 'medium', child: Text('متوسطة')),
                DropdownMenuItem(value: 'high', child: Text('عالية')),
              ],
              onChanged: (value) => setState(() => _priority = value!),
            ),
            const SizedBox(height: 24),

            _buildSectionTitle('الارتباط (اختياري)'),
            const SizedBox(height: 16),

            // Client Selector
            clientsAsync.when(
              data: (clients) {
                final selectedClient = clients
                    .where((c) => c.id == _selectedClientId)
                    .firstOrNull;
                return InkWell(
                  onTap: () => _showClientSelector(context, clients),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 16,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade500),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.store, color: Colors.grey),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            selectedClient?.name ?? 'ربط بعميل (اختياري)',
                            style: TextStyle(
                              fontSize: 16,
                              color: selectedClient != null
                                  ? Colors.black
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ),
                        if (_selectedClientId != null)
                          IconButton(
                            icon: const Icon(Icons.clear, size: 20),
                            onPressed: () =>
                                setState(() => _selectedClientId = null),
                          )
                        else
                          const Icon(Icons.arrow_drop_down, color: Colors.grey),
                      ],
                    ),
                  ),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(height: 16),

            // Campaign Selector
            campaignsAsync.when(
              data: (campaigns) {
                return DropdownButtonFormField<int>(
                  initialValue: _selectedCampaignId,
                  decoration: InputDecoration(
                    labelText: 'ربط بحملة (اختياري)',
                    prefixIcon: const Icon(Icons.campaign),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  items: campaigns
                      .map(
                        (c) => DropdownMenuItem(
                          value: c.id,
                          child: Text(c.title, overflow: TextOverflow.ellipsis),
                        ),
                      )
                      .toList(),
                  onChanged: (value) =>
                      setState(() => _selectedCampaignId = value),
                );
              },
              loading: () => const LinearProgressIndicator(),
              error: (err, stack) => Text('Error: $err'),
            ),
            const SizedBox(height: 32),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _saveTask,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.jabaliBlue,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'حفظ المهمة',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),
    );
  }
}
