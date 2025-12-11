import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../constants/app_colors.dart';

class PhoneSelectorDialog extends StatelessWidget {
  final List<String> phoneNumbers;

  const PhoneSelectorDialog({super.key, required this.phoneNumbers});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Row(
              children: [
                Icon(Icons.phone, color: AppColors.jabaliBlue, size: 28),
                SizedBox(width: 12),
                Text(
                  '\u0627\u062e\u062a\u0631 \u0631\u0642\u0645 \u0627\u0644\u0647\u0627\u062a\u0641',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const SizedBox(height: 20),
            ...phoneNumbers.map((phone) => _buildPhoneItem(context, phone)),
            const SizedBox(height: 12),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('\u0625\u0644\u063a\u0627\u0621'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhoneItem(BuildContext context, String phone) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: AppColors.jabaliBlue.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () async {
            Navigator.pop(context);
            final url = Uri.parse('tel:+967$phone');
            try {
              if (!await launchUrl(url)) {
                // Try to launch anyway if canLaunchUrl failed but launchUrl might work
                // or just log failure
                debugPrint('Could not launch $url');
              }
            } catch (e) {
              debugPrint('Error launching $url: $e');
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                    color: AppColors.jabaliBlue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.phone, color: Colors.white, size: 20),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    '+967 $phone',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.grey,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  static void show(BuildContext context, List<String> phoneNumbers) {
    if (phoneNumbers.isEmpty) return;

    if (phoneNumbers.length == 1) {
      // Direct call if only one number
      final url = Uri.parse('tel:+967${phoneNumbers.first}');
      try {
        launchUrl(url);
      } catch (e) {
        debugPrint('Error launching $url: $e');
      }
    } else {
      // Show dialog if multiple numbers
      showDialog(
        context: context,
        builder: (context) => PhoneSelectorDialog(phoneNumbers: phoneNumbers),
      );
    }
  }
}
