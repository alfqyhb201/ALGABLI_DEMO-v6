import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../widgets/animated_bottom_nav.dart';

class MainLayout extends StatefulWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/home')) return 0;
    if (location.startsWith('/customers')) return 1;
    if (location.startsWith('/tasks')) return 2;
    if (location.startsWith('/reports')) return 3;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/home');
        break;
      case 1:
        context.go('/customers');
        break;
      case 2:
        context.go('/tasks');
        break;
      case 3:
        context.go('/reports');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: AnimatedBottomNavBar(
        currentIndex: _calculateSelectedIndex(context),
        onTap: (index) => _onItemTapped(index, context),
      ),
    );
  }
}
