import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class EmployeeDetailsScreen extends ConsumerWidget {
  final int employeeId;

  const EmployeeDetailsScreen({super.key, required this.employeeId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تفاصيل الموظف'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: const Center(child: Text('هذه الميزة غير متوفرة حالياً')),
    );
  }
}
