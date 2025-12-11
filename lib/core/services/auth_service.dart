import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

// Provider for AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Provider for current user state
final currentUserProvider =
    NotifierProvider<CurrentUserNotifier, Map<String, dynamic>?>(
      CurrentUserNotifier.new,
    );

class CurrentUserNotifier extends Notifier<Map<String, dynamic>?> {
  @override
  Map<String, dynamic>? build() => null;

  void setUser(Map<String, dynamic> user) => state = user;
  void clear() => state = null;
}

class AuthService {
  final _storage = const FlutterSecureStorage();
  // Replace with your actual API URL
  final String _baseUrl = 'http://10.0.2.2:8000/api';

  Future<Map<String, dynamic>> login(
    String username,
    String password,
    bool isOffline,
  ) async {
    if (isOffline) {
      return _loginOffline(username, password);
    } else {
      return _loginOnline(username, password);
    }
  }

  Future<Map<String, dynamic>> _loginOnline(
    String username,
    String password,
  ) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/login'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        await _saveAuthData(data, username, password); // Save for offline use
        return {'success': true, 'data': data};
      } else {
        final error = jsonDecode(response.body);
        return {
          'success': false,
          'message': error['message'] ?? 'Login failed',
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }

  Future<Map<String, dynamic>> _loginOffline(
    String username,
    String password,
  ) async {
    final storedHash = await _storage.read(key: 'password_hash_$username');
    final storedUserData = await _storage.read(key: 'user_data_$username');

    if (storedHash == null || storedUserData == null) {
      return {
        'success': false,
        'message':
            'No offline data found for this user. Please login online first.',
      };
    }

    // Verify password hash (Simple check since we stored the hash from server)
    // Note: In a real app, you might want to hash the input password and compare,
    // but here we are comparing against the hash returned by the server which we stored.
    // Wait, the server returns the HASHED password from DB. We cannot verify it easily client-side
    // without knowing the hashing algorithm and salt (Bcrypt).
    // ALTERNATIVE: We store the PLAIN password locally (Encrypted by SecureStorage).

    final storedPassword = await _storage.read(key: 'password_$username');

    if (storedPassword == password) {
      final data = jsonDecode(storedUserData);
      return {'success': true, 'data': data};
    } else {
      return {'success': false, 'message': 'Invalid offline credentials'};
    }
  }

  Future<void> _saveAuthData(
    Map<String, dynamic> data,
    String username,
    String password,
  ) async {
    await _storage.write(key: 'auth_token', value: data['access_token']);
    await _storage.write(key: 'user_data_$username', value: jsonEncode(data));
    // Store plain password securely for offline verification since we can't replicate Bcrypt client-side easily
    await _storage.write(key: 'password_$username', value: password);
    await _storage.write(key: 'last_user', value: username);
  }

  Future<void> logout() async {
    await _storage.delete(key: 'auth_token');
    // We don't delete offline data so they can login offline later
  }

  Future<String?> getToken() async {
    return await _storage.read(key: 'auth_token');
  }

  Future<bool> isLoggedIn() async {
    return await _storage.containsKey(key: 'auth_token');
  }

  Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    try {
      final token = await getToken();
      if (token == null) {
        return {'success': false, 'message': 'User not authenticated'};
      }

      final response = await http.post(
        Uri.parse('$_baseUrl/change-password'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode({
          'current_password': currentPassword,
          'new_password': newPassword,
          'new_password_confirmation': newPasswordConfirmation,
        }),
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        // Update stored password for offline access
        final username = await _storage.read(key: 'last_user');
        if (username != null) {
          await _storage.write(key: 'password_$username', value: newPassword);
          if (data['password_hash'] != null) {
            await _storage.write(
              key: 'password_hash_$username',
              value: data['password_hash'],
            );
          }
        }
        return {'success': true, 'message': data['message']};
      } else {
        return {
          'success': false,
          'message': data['message'] ?? 'Failed to change password',
          'errors': data['errors'],
        };
      }
    } catch (e) {
      return {'success': false, 'message': 'Connection error: $e'};
    }
  }
}
