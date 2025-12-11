import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/sync_service.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;
  bool _isOfflineMode = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);

      final authService = ref.read(authServiceProvider);
      final result = await authService.login(
        _usernameController.text,
        _passwordController.text,
        _isOfflineMode,
      );

      if (mounted) {
        setState(() => _isLoading = false);

        if (result['success']) {
          // Update current user provider
          ref.read(currentUserProvider.notifier).setUser(result['data']);

          // Trigger initial sync
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('جاري مزامنة البيانات...'),
                duration: Duration(seconds: 2),
              ),
            );
          }
          await ref.read(syncServiceProvider).syncAll();

          // Navigate based on roles (simplified for now)
          // You can add more complex logic here based on 'roles' in result['data']
          if (mounted) {
            context.go('/home');
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(result['message'] ?? 'فشل تسجيل الدخول'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 40),
                _buildHeader(),
                const SizedBox(height: 48),
                _buildUsernameField(),
                const SizedBox(height: 20),
                _buildPasswordField(),
                const SizedBox(height: 12),
                _buildOfflineModeCheckbox(),
                const SizedBox(height: 32),
                _buildLoginButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          width: 100,
          height: 100,
          decoration: BoxDecoration(
            color: AppColors.jabaliBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Image.asset(
              'assets/images/icon.png',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.business,
                  size: 50,
                  color: AppColors.jabaliBlue,
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          'مرحباً بك',
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        const Text(
          'سجل دخولك للمتابعة',
          style: TextStyle(fontSize: 14, color: AppColors.textSecondary),
        ),
      ],
    );
  }

  Widget _buildUsernameField() {
    return TextFormField(
      controller: _usernameController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: 'اسم المستخدم',
        hintText: 'user123',
        prefixIcon: const Icon(Icons.person_outline),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال اسم المستخدم';
        }
        return null;
      },
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      controller: _passwordController,
      obscureText: _obscurePassword,
      decoration: InputDecoration(
        labelText: 'كلمة المرور',
        hintText: '••••••••',
        prefixIcon: const Icon(Icons.lock_outline),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility_off : Icons.visibility,
          ),
          onPressed: () => setState(() => _obscurePassword = !_obscurePassword),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'الرجاء إدخال كلمة المرور';
        }
        return null;
      },
    );
  }

  Widget _buildOfflineModeCheckbox() {
    return Row(
      children: [
        Checkbox(
          value: _isOfflineMode,
          onChanged: (value) {
            setState(() {
              _isOfflineMode = value ?? false;
            });
          },
          activeColor: AppColors.jabaliBlue,
        ),
        const Text('تسجيل دخول بدون إنترنت (Offline Mode)'),
      ],
    );
  }

  Widget _buildLoginButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        onPressed: _isLoading ? null : _handleLogin,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.jabaliBlue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: _isLoading
            ? const SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : const Text(
                'تسجيل الدخول',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
