import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' as drift;
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/yemen_locations.dart';
import '../../../core/database/app_database.dart';
import '../../../core/providers/clients_provider.dart';
import '../../../core/providers/database_provider.dart';
import '../../clients/presentation/client_employee_form_dialog.dart';

class CustomerFormScreen extends ConsumerStatefulWidget {
  final String clientType;
  final ClientsCompanion? clientToEdit; // Added for editing
  final int? clientId; // Added for editing

  const CustomerFormScreen({
    super.key,
    this.clientType = 'client',
    this.clientToEdit,
    this.clientId,
  });

  @override
  ConsumerState<CustomerFormScreen> createState() => _CustomerFormScreenState();
}

class _CustomerFormScreenState extends ConsumerState<CustomerFormScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  late final TextEditingController _addressController;
  late final TextEditingController _notesController;

  // Phone numbers list
  final List<TextEditingController> _phoneControllers = [];

  // Dropdowns
  String? _selectedType;
  String? _selectedProvince;
  String? _selectedDistrict;
  String? _selectedImportance;
  String? _selectedLoyaltyLevel;
  bool _isAgent = false;

  // GPS and Images
  String? _gpsLocation;
  bool _isLoadingLocation = false;
  DateTime? _lastVisit;
  final List<String> _imagePaths = [];
  String? _profileImagePath; // Added for profile image
  final ImagePicker _imagePicker = ImagePicker();

  final List<String> _customerTypes = [
    'تاجر دراجات نارية',
    'تاجر قطع غيار',
    'تاجر زيوت',
    'متجر متخصص',
    'تاجر جملة',
    'ورشة / ميكانيكي',
  ];

  final List<String> _importanceLevels = ['A', 'B', 'C'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    // Initialize with existing data if editing
    final client = widget.clientToEdit;

    _nameController = TextEditingController(text: client?.name.value);
    _emailController = TextEditingController(text: client?.email.value);
    _addressController = TextEditingController(text: client?.address.value);
    _notesController = TextEditingController(text: client?.notes.value);

    _selectedType = client?.category.value;
    _selectedProvince = client?.province.value;
    _selectedDistrict = client?.district.value;
    _selectedImportance = client?.importance.value;
    _selectedLoyaltyLevel = client?.loyaltyLevel.value;
    _isAgent = client?.isAgent.value ?? (widget.clientType == 'agent');
    _gpsLocation = client?.gpsLocation.value;
    _lastVisit = client?.lastVisit.value ?? DateTime.now();
    _profileImagePath = client?.profileImage.value; // Load profile image

    // Initialize phone controllers
    if (client != null && client.phone.value != null) {
      for (final phone in client.phone.value!) {
        _phoneControllers.add(TextEditingController(text: phone));
      }
    } else {
      _phoneControllers.add(TextEditingController());
    }

    // Initialize images
    if (client != null && client.images.value != null) {
      _imagePaths.addAll(client.images.value!);
    }
  }

  @override
  void dispose() {
    _tabController.dispose();
    _nameController.dispose();
    _addressController.dispose();
    _notesController.dispose();
    for (var controller in _phoneControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _pickProfileImage() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.gallery, // Or show dialog for camera/gallery
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _profileImagePath = photo.path;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ في اختيار الصورة: $e')));
      }
    }
  }

  void _addPhoneField() {
    if (_phoneControllers.length < 3) {
      setState(() {
        _phoneControllers.add(TextEditingController());
      });
    }
  }

  void _removePhoneField(int index) {
    if (_phoneControllers.length > 1) {
      setState(() {
        _phoneControllers[index].dispose();
        _phoneControllers.removeAt(index);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final citiesAsync = ref.watch(watchCitiesProvider);
    final classificationsAsync = ref.watch(watchClassificationsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('إضافة عميل جديد'),
        elevation: 0,
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.jabaliBlue,
          unselectedLabelColor: const Color.fromARGB(
            255,
            0,
            0,
            0,
          ), // A slightly faded version of the brand color
          indicatorColor:
              AppColors.jabaliBlue, // The main brand color for the indicator
          tabs: const [
            Tab(text: 'البيانات الأساسية'),
            Tab(text: 'التقييم'),
            Tab(text: 'الملاحظات'),
          ],
        ),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildBasicInfoTab(citiesAsync, classificationsAsync),
                  _buildEvaluationTab(),
                  _buildNotesTab(),
                ],
              ),
            ),
            _buildBottomButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildBasicInfoTab(
    AsyncValue<List<City>> citiesAsync,
    AsyncValue<List<Classification>> classificationsAsync,
  ) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Image Section
          Center(
            child: Stack(
              children: [
                GestureDetector(
                  onTap: _pickProfileImage,
                  child: Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.grey.shade200,
                      border: Border.all(color: AppColors.jabaliBlue, width: 2),
                      image: _profileImagePath != null
                          ? DecorationImage(
                              image: _profileImagePath!.startsWith('http')
                                  ? NetworkImage(_profileImagePath!)
                                  : FileImage(File(_profileImagePath!))
                                        as ImageProvider,
                              fit: BoxFit.cover,
                            )
                          : null,
                    ),
                    child: _profileImagePath == null
                        ? const Icon(Icons.person, size: 50, color: Colors.grey)
                        : null,
                  ),
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: _pickProfileImage,
                    child: Container(
                      padding: const EdgeInsets.all(6),
                      decoration: const BoxDecoration(
                        color: AppColors.jabaliBlue,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        size: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildSectionTitle('معلومات العميل'),
          const SizedBox(height: 16),

          // اسم العميل
          _buildTextField(
            controller: _nameController,
            label: 'اسم العميل',
            hint: 'مثال: الجبلي',
            icon: Icons.store,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال اسم العميل';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // نوع العميل
          classificationsAsync.when(
            data: (classifications) {
              final types = classifications
                  .where((c) => c.type == 'client' || c.type == null)
                  .map((c) => c.name)
                  .toList();

              // Fallback if empty (e.g. before first sync)
              if (types.isEmpty) {
                types.addAll(_customerTypes);
              }

              return _buildDropdown(
                label: 'نوع العميل',
                value: _selectedType,
                items: types,
                icon: Icons.category,
                onChanged: (value) => setState(() => _selectedType = value),
                validator: (value) {
                  if (value == null) return 'الرجاء اختيار نوع العميل';
                  return null;
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          // البريد الإلكتروني
          _buildTextField(
            controller: _emailController,
            label: 'البريد الإلكتروني',
            hint: 'example@domain.com',
            icon: Icons.email,
            validator: (value) {
              if (value != null && value.isNotEmpty) {
                if (!value.contains('@')) return 'بريد إلكتروني غير صحيح';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // أرقام الهاتف
          _buildSectionTitle('أرقام الهاتف'),
          const SizedBox(height: 12),
          ..._buildPhoneFields(),
          if (_phoneControllers.length < 3)
            TextButton.icon(
              onPressed: _addPhoneField,
              icon: const Icon(Icons.add_circle_outline),
              label: const Text('إضافة رقم آخر'),
              style: TextButton.styleFrom(
                foregroundColor: AppColors.jabaliBlue,
              ),
            ),
          const SizedBox(height: 24),

          // الموقع
          _buildSectionTitle('الموقع'),
          const SizedBox(height: 16),

          citiesAsync.when(
            data: (cities) {
              final provinces = cities
                  .map((c) => c.governorate)
                  .where((g) => g != null)
                  .toSet()
                  .cast<String>()
                  .toList();

              // Fallback
              if (provinces.isEmpty) {
                provinces.addAll(YemenLocations.getProvinces());
              }

              // Ensure selected province is in the list
              if (_selectedProvince != null &&
                  !provinces.contains(_selectedProvince)) {
                provinces.add(_selectedProvince!);
              }

              return Column(
                children: [
                  // المحافظة
                  _buildDropdown(
                    label: 'المحافظة',
                    value: _selectedProvince,
                    items: provinces,
                    icon: Icons.location_city,
                    onChanged: (value) {
                      setState(() {
                        _selectedProvince = value;
                        _selectedDistrict = null;
                      });
                    },
                    validator: (value) {
                      if (value == null) return 'الرجاء اختيار المحافظة';
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // المديرية
                  _buildDropdown(
                    label: 'المديرية',
                    value: _selectedDistrict,
                    items: _selectedProvince != null
                        ? (() {
                            final districts = cities
                                .where(
                                  (c) => c.governorate == _selectedProvince,
                                )
                                .map((c) => c.name)
                                .toList();
                            if (districts.isEmpty) {
                              final defaultDistricts = List<String>.from(
                                YemenLocations.getDistricts(_selectedProvince!),
                              );
                              if (_selectedDistrict != null &&
                                  !defaultDistricts.contains(
                                    _selectedDistrict,
                                  )) {
                                defaultDistricts.add(_selectedDistrict!);
                              }
                              return defaultDistricts;
                            }

                            if (_selectedDistrict != null &&
                                !districts.contains(_selectedDistrict)) {
                              districts.add(_selectedDistrict!);
                            }
                            return districts;
                          })()
                        : [],
                    icon: Icons.location_on,
                    enabled: _selectedProvince != null,
                    onChanged: (value) =>
                        setState(() => _selectedDistrict = value),
                    validator: (value) {
                      if (value == null) return 'الرجاء اختيار المديرية';
                      return null;
                    },
                  ),
                ],
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, s) => Text('Error: $e'),
          ),
          const SizedBox(height: 16),

          // العنوان التفصيلي
          _buildTextField(
            controller: _addressController,
            label: 'العنوان التفصيلي',
            hint: 'مثال: شارع الستين، بجوار مسجد النور',
            icon: Icons.home,
            maxLines: 2,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'الرجاء إدخال العنوان';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // الموقع الجغرافي
          _buildLocationButton(),
        ],
      ),
    );
  }

  Widget _buildEvaluationTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('تقييم العميل'),
          const SizedBox(height: 16),

          _buildDropdown(
            label: 'درجة الأهمية',
            value: _selectedImportance,
            items: _importanceLevels,
            icon: Icons.star,
            onChanged: (value) => setState(() => _selectedImportance = value),
            hint: 'A: عميل مهم جداً، B: عميل مهم...',
          ),

          // خيار: هل هو وكيل؟
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.jabaliGold.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.verified,
                    color: AppColors.jabaliGold,
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'هل العميل وكيل أيضاً؟',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'الوكلاء لديهم صلاحيات ومميزات إضافية',
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                      ),
                    ],
                  ),
                ),
                Switch(
                  value: _isAgent,
                  onChanged: (value) => setState(() => _isAgent = value),
                  activeThumbColor: AppColors.jabaliGold,
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),

          _buildInfoCard(
            'معلومات التقييم',
            'سيتم تحديث تقييم العميل تلقائياً بناءً على:\n'
                '• حجم المشتريات\n'
                '• انتظام الزيارات\n'
                '• الالتزام بالدفع',
          ),
          const SizedBox(height: 16),

          // تاريخ آخر زيارة
          _buildDatePicker(
            label: 'تاريخ آخر زيارة',
            selectedDate: _lastVisit,
            onChanged: (date) => setState(() => _lastVisit = date),
          ),
        ],
      ),
    );
  }

  Widget _buildDatePicker({
    required String label,
    required DateTime? selectedDate,
    required ValueChanged<DateTime> onChanged,
  }) {
    return InkWell(
      onTap: () async {
        final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: selectedDate ?? DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime.now(),
        );
        if (picked != null && picked != selectedDate) {
          onChanged(picked);
        }
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(Icons.calendar_today, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    selectedDate != null
                        ? '${selectedDate.year}-${selectedDate.month.toString().padLeft(2, '0')}-${selectedDate.day.toString().padLeft(2, '0')}'
                        : 'اضغط لاختيار التاريخ',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNotesTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSectionTitle('ملاحظات إضافية'),
          const SizedBox(height: 16),

          _buildTextField(
            controller: _notesController,
            label: 'الملاحظات',
            hint: 'أضف أي ملاحظات مهمة عن العميل...',
            icon: Icons.note,
            maxLines: 8,
          ),
          const SizedBox(height: 16),

          _buildImageUploadSection(),
        ],
      ),
    );
  }

  List<Widget> _buildPhoneFields() {
    return List.generate(_phoneControllers.length, (index) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                controller: _phoneControllers[index],
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(9),
                ],
                decoration: InputDecoration(
                  labelText: 'رقم الهاتف ${index + 1}',
                  hintText: '777123456',
                  prefixIcon: const Icon(Icons.phone),
                  prefixText: '+967 ',
                  prefixStyle: const TextStyle(
                    color: AppColors.jabaliBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
                validator: (value) {
                  if (index == 0 && (value == null || value.isEmpty)) {
                    return 'الرجاء إدخال رقم الهاتف';
                  }
                  if (value != null && value.isNotEmpty && value.length != 9) {
                    return 'رقم الهاتف يجب أن يكون 9 أرقام';
                  }
                  return null;
                },
              ),
            ),
            if (_phoneControllers.length > 1)
              IconButton(
                icon: const Icon(Icons.remove_circle, color: AppColors.danger),
                onPressed: () => _removePhoneField(index),
              ),
          ],
        ),
      );
    });
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.white,
      ),
      validator: validator,
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required IconData icon,
    required void Function(String?) onChanged,
    String? Function(String?)? validator,
    String? hint,
    bool enabled = true,
  }) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: enabled ? Colors.white : Colors.grey.shade100,
        hintText: hint,
      ),
      items: items.map((item) {
        return DropdownMenuItem(value: item, child: Text(item));
      }).toList(),
      onChanged: enabled ? onChanged : null,
      validator: validator,
    );
  }

  Widget _buildSectionTitle(String title) {
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
        const SizedBox(width: 8),
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

  Future<void> _getCurrentLocation() async {
    setState(() => _isLoadingLocation = true);

    try {
      // Check if location services are enabled
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('الرجاء تفعيل خدمات الموقع')),
          );
        }
        setState(() => _isLoadingLocation = false);
        return;
      }

      // Check permission
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('تم رفض صلاحية الموقع')),
            );
          }
          setState(() => _isLoadingLocation = false);
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'صلاحية الموقع مرفوضة بشكل دائم. الرجاء تفعيلها من الإعدادات',
              ),
            ),
          );
        }
        setState(() => _isLoadingLocation = false);
        return;
      }

      // 1. Try to get last known position first (fastest)
      Position? position = await Geolocator.getLastKnownPosition();

      // 2. If no last known position, request current position with timeout
      if (position == null) {
        try {
          // Use a shorter timeout and lower accuracy initially for speed
          position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.medium, // Reduced from high to medium
              timeLimit: Duration(seconds: 5), // Reduced timeout
            ),
          );
        } on TimeoutException catch (_) {
          // If timeout, try one last time with low accuracy
          try {
            position = await Geolocator.getCurrentPosition(
              locationSettings: const LocationSettings(
                accuracy: LocationAccuracy.low,
                timeLimit: Duration(seconds: 5),
              ),
            );
          } catch (e) {
            // Ignore second failure
          }
        } catch (e) {
          // Handle other errors
        }
      }

      // 3. Last resort: Request with low accuracy if still null
      if (position == null) {
        try {
          position = await Geolocator.getCurrentPosition(
            locationSettings: const LocationSettings(
              accuracy: LocationAccuracy.low,
              timeLimit: Duration(seconds: 5),
            ),
          );
        } catch (e) {
          // Ignore
        }
      }

      if (position != null) {
        setState(() {
          _gpsLocation = '${position!.latitude},${position!.longitude}';
          _isLoadingLocation = false;
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم تحديد الموقع بنجاح'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } else {
        throw Exception('تعذر تحديد الموقع، يرجى المحاولة مرة أخرى');
      }
    } catch (e) {
      setState(() => _isLoadingLocation = false);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ في تحديد الموقع: $e')));
      }
    }
  }

  Widget _buildLocationButton() {
    return InkWell(
      onTap: _isLoadingLocation ? null : _getCurrentLocation,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.my_location, color: AppColors.jabaliBlue),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'تحديد الموقع الجغرافي (GPS)',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _gpsLocation ?? 'اضغط لتحديد الموقع الحالي',
                    style: TextStyle(
                      fontSize: 12,
                      color: _gpsLocation != null
                          ? AppColors.success
                          : Colors.grey,
                      fontWeight: _gpsLocation != null
                          ? FontWeight.bold
                          : FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            if (_isLoadingLocation)
              const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
            else
              Icon(
                _gpsLocation != null
                    ? Icons.check_circle
                    : Icons.arrow_forward_ios,
                size: 16,
                color: _gpsLocation != null ? AppColors.success : Colors.grey,
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _takePicture() async {
    try {
      final XFile? photo = await _imagePicker.pickImage(
        source: ImageSource.camera,
        maxWidth: 1920,
        maxHeight: 1080,
        imageQuality: 85,
      );

      if (photo != null) {
        setState(() {
          _imagePaths.add(photo.path);
        });

        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('تم إضافة الصورة بنجاح'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('خطأ في فتح الكاميرا: $e')));
      }
    }
  }

  void _removeImage(int index) {
    setState(() {
      _imagePaths.removeAt(index);
    });
  }

  Widget _buildImageUploadSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (_imagePaths.isNotEmpty) ...[
          SizedBox(
            height: 120,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: _imagePaths.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.only(left: 8),
                  width: 120,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey.shade300),
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          _imagePaths[index],
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              color: Colors.grey.shade200,
                              child: const Icon(Icons.image, size: 40),
                            );
                          },
                        ),
                      ),
                      Positioned(
                        top: 4,
                        left: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.danger,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 16,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
        ],
        InkWell(
          onTap: _takePicture,
          child: Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: Colors.grey.shade300,
                style: BorderStyle.solid,
              ),
            ),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.jabaliBlue.withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.add_a_photo,
                    size: 40,
                    color: AppColors.jabaliBlue,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  _imagePaths.isEmpty ? 'إضافة صورة' : 'إضافة صورة أخرى',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  _imagePaths.isEmpty
                      ? 'اضغط لالتقاط صورة للمحل'
                      : '${_imagePaths.length} صور مضافة',
                  style: TextStyle(
                    fontSize: 12,
                    color: _imagePaths.isNotEmpty
                        ? AppColors.success
                        : Colors.grey,
                    fontWeight: _imagePaths.isNotEmpty
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInfoCard(String title, String content) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.jabaliBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.jabaliBlue.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(
                Icons.info_outline,
                color: AppColors.jabaliBlue,
                size: 20,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppColors.jabaliBlue,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () {
                // Save as draft
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم الحفظ كمسودة')),
                );
              },
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                side: BorderSide(
                  color: AppColors.jabaliBlue.withValues(alpha: 0.3),
                ),
              ),
              child: const Text('حفظ كمسودة'),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final controller = ref.read(
                    clientControllerProvider.notifier,
                  );

                  // Check for duplicate name if adding new client
                  if (widget.clientId == null) {
                    final existingClients = await ref.read(
                      clientsProvider.future,
                    );

                    try {
                      final duplicates = existingClients.where(
                        (c) => c.name == _nameController.text,
                      );

                      if (duplicates.isNotEmpty) {
                        final duplicate = duplicates.first;
                        if (mounted) {
                          final shouldAddEmployee = await showDialog<bool>(
                            context: context,
                            builder: (context) => AlertDialog(
                              title: const Text('تنبيه'),
                              content: const Text(
                                'هذا العميل مسجل مسبقًا، هل ترغب بإضافة فرع للعميل او موظف يعمل لدى هذا العميل؟',
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () =>
                                      Navigator.pop(context, false),
                                  child: const Text('إلغاء'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context, true),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.jabaliBlue,
                                    foregroundColor: Colors.white,
                                  ),
                                  child: const Text('نعم، أضف موظف'),
                                ),
                              ],
                            ),
                          );

                          if (shouldAddEmployee == true) {
                            if (mounted) {
                              Navigator.pop(context); // Close form
                              showDialog(
                                context: context,
                                builder: (_) => ClientEmployeeFormDialog(
                                  clientId: duplicate.id,
                                ),
                              );
                            }
                            return;
                          } else {
                            return; // Cancel save
                          }
                        }
                      }
                    } catch (e) {
                      // No duplicate found, proceed
                    }
                  }

                  // Create client companion
                  final client = ClientsCompanion(
                    id: widget.clientId != null
                        ? drift.Value(widget.clientId!)
                        : const drift.Value.absent(),
                    name: drift.Value(_nameController.text),
                    category: drift.Value(_selectedType),
                    phone: drift.Value(
                      _phoneControllers.map((c) => c.text).toList(),
                    ),
                    address: drift.Value(_addressController.text),
                    gpsLocation: drift.Value(_gpsLocation),
                    images: drift.Value(_imagePaths),
                    profileImage: drift.Value(
                      _profileImagePath,
                    ), // Save profile image
                    importance: drift.Value(_selectedImportance),
                    province: drift.Value(_selectedProvince),
                    district: drift.Value(_selectedDistrict),
                    notes: drift.Value(_notesController.text),
                    isAgent: drift.Value(_isAgent),
                    loyaltyLevel: drift.Value(
                      _selectedLoyaltyLevel ?? 'medium',
                    ),
                    lastVisit: drift.Value(_lastVisit),
                    email: drift.Value(_emailController.text),
                  );

                  if (widget.clientId != null) {
                    // Update existing
                    await controller.updateClient(client);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم تحديث بيانات العميل بنجاح'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  } else {
                    // Add new
                    await controller.addClient(client);
                    if (mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('تم إضافة العميل بنجاح'),
                          backgroundColor: AppColors.success,
                        ),
                      );
                    }
                  }

                  if (mounted) {
                    Navigator.pop(context);
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.jabaliRed,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'حفظ وإرسال',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
