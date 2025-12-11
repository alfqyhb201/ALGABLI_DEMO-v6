import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:al_jabali_system/features/settings/presentation/change_password_screen.dart';
import 'package:al_jabali_system/core/services/auth_service.dart';

// Manual mock to avoid build_runner dependency in this environment
class MockAuthService extends Fake implements AuthService {
  final Map<String, dynamic> result;

  MockAuthService({this.result = const {'success': true, 'message': 'Success'}});

  @override
  Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    return result;
  }
}

class FakeAuthServiceWithError extends Fake implements AuthService {
  @override
  Future<Map<String, dynamic>> changePassword(
    String currentPassword,
    String newPassword,
    String newPasswordConfirmation,
  ) async {
    return {
      'success': false,
      'message': 'Error occurred',
      'errors': {
        'current_password': ['Invalid password'],
      },
    };
  }
}

void main() {
  Widget createWidgetUnderTest(AuthService authService) {
    return ProviderScope(
      overrides: [
        authServiceProvider.overrideWithValue(authService),
      ],
      child: const MaterialApp(
        home: ChangePasswordScreen(),
      ),
    );
  }

  testWidgets('ChangePasswordScreen renders correctly', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(MockAuthService()));

    expect(find.text('تغيير كلمة المرور'), findsOneWidget);
    expect(find.text('كلمة المرور الحالية'), findsOneWidget);
    expect(find.text('كلمة المرور الجديدة'), findsOneWidget);
    expect(find.text('تأكيد كلمة المرور الجديدة'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('Validates empty fields', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(MockAuthService()));

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('يرجى إدخال كلمة المرور الحالية'), findsOneWidget);
    expect(find.text('يرجى إدخال كلمة المرور الجديدة'), findsOneWidget);
  });

  testWidgets('Validates password mismatch', (tester) async {
    await tester.pumpWidget(createWidgetUnderTest(MockAuthService()));

    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الحالية'), 'oldpass');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الجديدة'), 'newpass123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'تأكيد كلمة المرور الجديدة'),
        'different');

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('كلمات المرور غير متطابقة'), findsOneWidget);
  });

  testWidgets('Calls AuthService.changePassword on successful submission',
      (tester) async {
    final mockService = MockAuthService();
    await tester.pumpWidget(createWidgetUnderTest(mockService));

    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الحالية'), 'oldpass');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الجديدة'), 'newpass123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'تأكيد كلمة المرور الجديدة'),
        'newpass123');

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pump(); // Start loading
    await tester.pumpAndSettle(); // Finish loading and snackbar

    expect(find.text('Success'), findsOneWidget);
  });

    testWidgets('Shows error message on failure',
      (tester) async {
    final mockService = FakeAuthServiceWithError();
    await tester.pumpWidget(createWidgetUnderTest(mockService));

    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الحالية'), 'oldpass');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'كلمة المرور الجديدة'), 'newpass123');
    await tester.enterText(
        find.widgetWithText(TextFormField, 'تأكيد كلمة المرور الجديدة'),
        'newpass123');

    final button = find.byType(ElevatedButton);
    await tester.tap(button);
    await tester.pump(); // Start loading
    await tester.pumpAndSettle(); // Finish loading and snackbar

    expect(find.textContaining('Error occurred'), findsOneWidget);
    expect(find.textContaining('Invalid password'), findsOneWidget);
  });
}
