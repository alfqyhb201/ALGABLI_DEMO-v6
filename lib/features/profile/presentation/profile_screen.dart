import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الملف الشخصي')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Center(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: AssetImage('assets/images/icon.png'),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'أحمد المسوق',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'مسوق ميداني - فرع صنعاء',
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            _buildInfoTile('رقم الهاتف', '780828695', Icons.phone),
            _buildInfoTile(
              'البريد الإلكتروني',
              'ahmed@aljabali.com',
              Icons.email,
            ),
            _buildInfoTile(
              'تاريخ الانضمام',
              '01/01/2024',
              Icons.calendar_today,
            ),
            _buildInfoTile('المنطقة', 'صنعاء - حدة', Icons.location_on),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoTile(String label, String value, IconData icon) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: ListTile(
        leading: Icon(icon, color: AppColors.primary),
        title: Text(
          label,
          style: const TextStyle(fontSize: 12, color: AppColors.textSecondary),
        ),
        subtitle: Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
