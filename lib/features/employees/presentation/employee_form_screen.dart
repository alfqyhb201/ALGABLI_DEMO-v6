import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EmployeeFormScreen extends ConsumerWidget {
  const EmployeeFormScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('إضافة موظف جديد')),
      body: const Center(child: Text('هذه الميزة غير متوفرة حالياً')),
    );
  }
}
