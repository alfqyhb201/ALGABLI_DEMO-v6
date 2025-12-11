import 'dart:convert';
import '../database/app_database.dart';

extension ClientExtensions on Client {
  bool get isAgent => category == 'وكيل';

  List<String> get shopPhoneNumbers {
    if (phone == null) return [];
    return phone!.expand((p) {
      if (p.trim().startsWith('[')) {
        try {
          final decoded = jsonDecode(p);
          if (decoded is List) {
            return decoded.map((e) => e.toString());
          }
        } catch (_) {}
      }
      // Also handle potential double quotes if not JSON list but just quoted string
      if (p.startsWith('"') && p.endsWith('"')) {
        p = p.substring(1, p.length - 1);
      }

      // Aggressive cleaning: remove everything except digits and +
      // This handles cases like `["\777..."]` where JSON decoding might fail or leave artifacts
      final clean = p.replaceAll(RegExp(r'[^\d+]'), '');
      if (clean.isNotEmpty) {
        return [clean];
      }

      return [p]; // Fallback to original if cleaning results in empty string
    }).toList();
  }
}
