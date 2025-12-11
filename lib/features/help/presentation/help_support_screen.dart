import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('المساعدة والدعم'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionTitle('الأسئلة الشائعة'),
          _buildFAQItem(
            'كيف أضيف عميل جديد؟',
            'اذهب إلى شاشة العملاء واضغط على زر "+" في الأعلى، ثم املأ البيانات المطلوبة.',
          ),
          _buildFAQItem(
            'كيف أبدأ مهمة جديدة؟',
            'من شاشة المهام، اضغط على المهمة المطلوبة ثم اضغط "بدء المهمة".',
          ),
          _buildFAQItem(
            'كيف أعرض التقارير؟',
            'اذهب إلى تبويب "التقارير" من الشريط السفلي لعرض جميع الإحصائيات.',
          ),
          _buildFAQItem(
            'ماذا أفعل إذا نسيت كلمة المرور؟',
            'اضغط على "نسيت كلمة المرور؟" في شاشة تسجيل الدخول واتبع التعليمات.',
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('تواصل معنا'),
          const SizedBox(height: 16),
          _buildContactCard(
            Icons.phone,
            'الاتصال',
            '+967 777 123 456',
            AppColors.jabaliBlue,
          ),
          _buildContactCard(
            Icons.email,
            'البريد الإلكتروني',
            'support@aljabali.com',
            AppColors.success,
          ),
          _buildContactCard(
            Icons.chat_bubble,
            'الدردشة المباشرة',
            'متاح من 8 ص - 5 م',
            AppColors.warning,
          ),
          const SizedBox(height: 24),
          _buildSectionTitle('معلومات التطبيق'),
          const SizedBox(height: 16),
          _buildInfoTile('الإصدار', '1.0.0'),
          _buildInfoTile('آخر تحديث', '23 نوفمبر 2025'),
          _buildInfoTile('المطور', 'شركة الجبلي للتجارة'),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
      ),
    );
  }

  Widget _buildFAQItem(String question, String answer) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ExpansionTile(
        title: Text(
          question,
          style: const TextStyle(fontWeight: FontWeight.w600),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              answer,
              style: const TextStyle(color: Colors.grey, height: 1.5),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard(IconData icon, String title, String subtitle, Color color) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        leading: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: () {},
      ),
    );
  }

  Widget _buildInfoTile(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
