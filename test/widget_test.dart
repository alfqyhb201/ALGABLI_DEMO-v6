import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:aljabali_system/main.dart';

void main() {
  testWidgets('App smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const ProviderScope(child: AlJabaliApp()));
    await tester.pump(); // Start animations
    
    // Verify that the splash screen appears initially
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    
    // Wait for the splash screen timer (3 seconds) and animation (1.5 seconds)
    await tester.pump(const Duration(seconds: 4));
    await tester.pumpAndSettle(); // Wait for navigation animation
  });
}
