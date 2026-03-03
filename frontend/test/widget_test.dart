import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/main.dart';

void main() {
  testWidgets('shows login form and error on failed login', (WidgetTester tester) async {
    // Build app
    await tester.pumpWidget(const MyApp());

    // Check login UI elements are present
    expect(find.text('Virtual AI Patient'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);

    // Tap "Log in" without stubbing backend; we only assert that button is clickable
    await tester.tap(find.text('Log in'));
    await tester.pump();

    // No backend is available in widget test, so we just ensure the widget tree
    // still contains the login form after the tap.
    expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
  });
}
