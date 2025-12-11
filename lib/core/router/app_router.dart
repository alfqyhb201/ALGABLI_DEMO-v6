import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/presentation/login_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/auth/presentation/splash_screen.dart';
import '../../features/clients/presentation/clients_list_screen.dart';
import '../../features/clients/presentation/client_details_screen.dart';
import '../../features/tasks/presentation/tasks_screen.dart';
import '../../features/reports/presentation/reports_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/profile/presentation/profile_screen.dart';
import '../../features/campaigns/presentation/campaign_details_screen.dart';
import '../../features/customers/presentation/customer_form_screen.dart';
import '../../features/help/presentation/help_support_screen.dart';
import '../../features/activity/presentation/activity_log_screen.dart';
import '../../features/employees/presentation/employee_form_screen.dart';
import '../../features/employees/presentation/employee_details_screen.dart';
import '../../features/tasks/presentation/create_task_screen.dart';
import '../../features/tasks/presentation/task_details_screen.dart';
import '../../features/campaigns/presentation/campaigns_list_screen.dart';
import '../../features/manager/screens/manager_dashboard_screen.dart';
import '../../features/manager/screens/manager_campaigns_screen.dart';
import '../../features/manager/screens/team_performance_screen.dart';
import '../../features/manager/screens/manager_reports_screen.dart';
import '../../features/manager/screens/user_management_screen.dart';
import '../../features/settings/presentation/sync_settings_screen.dart';
import '../../features/settings/presentation/change_password_screen.dart';
import '../layout/main_layout.dart';

import '../../core/services/auth_service.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home', // Changed to home, redirect will handle login
    redirect: (context, state) async {
      final authService = ref.read(authServiceProvider);
      final isLoggedIn = await authService.isLoggedIn();
      final isLoggingIn = state.uri.path == '/login';
      final isSplash = state.uri.path == '/';

      if (isSplash) return null; // Let splash screen handle initial check

      if (!isLoggedIn && !isLoggingIn) {
        return '/login';
      }
      if (isLoggedIn && isLoggingIn) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
      GoRoute(path: '/login', builder: (context, state) => const LoginScreen()),
      GoRoute(
        path: '/manager-home',
        builder: (context, state) => const ManagerDashboardScreen(),
      ),
      GoRoute(
        path: '/manager-campaigns',
        builder: (context, state) => const ManagerCampaignsScreen(),
      ),
      GoRoute(
        path: '/team-performance',
        builder: (context, state) => const TeamPerformanceScreen(),
      ),
      GoRoute(
        path: '/manager-reports',
        builder: (context, state) => const ManagerReportsScreen(),
      ),
      GoRoute(
        path: '/user-management',
        builder: (context, state) => const UserManagementScreen(),
      ),
      GoRoute(
        path: '/settings',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'sync',
            builder: (context, state) => const SyncSettingsScreen(),
          ),
          GoRoute(
            path: 'change-password',
            builder: (context, state) => const ChangePasswordScreen(),
          ),
        ],
      ),
      GoRoute(
        path: '/profile',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/campaigns/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return CampaignDetailsScreen(campaignId: id);
        },
      ),
      GoRoute(
        path: '/customer-form',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CustomerFormScreen(),
      ),
      GoRoute(
        path: '/add-client',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return CustomerFormScreen(clientType: extra?['type'] ?? 'client');
        },
      ),
      GoRoute(
        path: '/client-details/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return ClientDetailsScreen(clientId: id);
        },
      ),
      GoRoute(
        path: '/add-employee',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const EmployeeFormScreen(),
      ),
      GoRoute(
        path: '/employee-details/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return EmployeeDetailsScreen(employeeId: id);
        },
      ),
      GoRoute(
        path: '/help',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const HelpSupportScreen(),
      ),
      GoRoute(
        path: '/activity-log',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const ActivityLogScreen(),
      ),
      GoRoute(
        path: '/create-task',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CreateTaskScreen(),
      ),
      GoRoute(
        path: '/task-details/:id',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) {
          final id = state.pathParameters['id']!;
          return TaskDetailsScreen(taskId: id);
        },
      ),
      GoRoute(
        path: '/campaigns',
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const CampaignsListScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return MainLayout(child: child);
        },
        routes: [
          GoRoute(
            path: '/home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/customers',
            builder: (context, state) => const ClientsListScreen(),
          ),
          GoRoute(
            path: '/tasks',
            builder: (context, state) => const TasksScreen(),
          ),
          GoRoute(
            path: '/reports',
            builder: (context, state) => const ReportsScreen(),
          ),
        ],
      ),
    ],
  );
}
