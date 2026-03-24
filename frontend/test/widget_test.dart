import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;

void main() {
  testWidgets('shows user-facing auth controls', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authRepository: _FakeAuthRepository())),
    );
    expect(find.text('Virtual AI Patient'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Username'), findsOneWidget);
    expect(find.widgetWithText(TextField, 'Password'), findsOneWidget);
    expect(find.text('Log in'), findsOneWidget);
    expect(find.text('Create account'), findsOneWidget);
    expect(find.text('Forgot password?'), findsOneWidget);
  });

  testWidgets('opens create-account dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authRepository: _FakeAuthRepository())),
    );

    await tester.ensureVisible(find.text('Create account'));
    await tester.tap(find.text('Create account'));
    await tester.pumpAndSettle();

    expect(find.byType(AlertDialog), findsOneWidget);
    expect(find.text('Create account'), findsWidgets);
    expect(find.widgetWithText(TextField, 'Email'), findsOneWidget);
  });

  testWidgets('opens reset-password dialog', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authRepository: _FakeAuthRepository())),
    );

    await tester.ensureVisible(find.text('Forgot password?'));
    await tester.tap(find.text('Forgot password?'));
    await tester.pumpAndSettle();

    expect(find.text('Reset password'), findsOneWidget);
    expect(find.text('Send instructions'), findsOneWidget);
  });

  testWidgets('shows friendly auth error on 401', (WidgetTester tester) async {
    final repo = _FakeAuthRepository(
      loginError: DioException(
        requestOptions: RequestOptions(path: '/auth/login'),
        response: Response<void>(
          requestOptions: RequestOptions(path: '/auth/login'),
          statusCode: 401,
        ),
        type: DioExceptionType.badResponse,
      ),
    );

    await tester
        .pumpWidget(MaterialApp(home: LoginScreen(authRepository: repo)));
    await tester.enterText(
      find.widgetWithText(TextField, 'Username'),
      'wrong-user',
    );
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'wrong-pass',
    );
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Could not sign you in'), findsOneWidget);
    expect(find.text('Reset password'), findsOneWidget);
  });

  testWidgets('navigates to dashboard on successful login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(home: LoginScreen(authRepository: _FakeAuthRepository())),
    );

    await tester.enterText(find.widgetWithText(TextField, 'Username'), 'admin');
    await tester.enterText(
        find.widgetWithText(TextField, 'Password'), 'secret');
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Dashboard'), findsOneWidget);
  });
}

class _FakeAuthRepository implements AuthRepositoryContract {
  _FakeAuthRepository({this.loginError});

  final Object? loginError;

  @override
  Future<AuthSession> loginAndVerify({
    required String username,
    required String password,
  }) async {
    if (loginError != null) {
      throw loginError!;
    }

    final user = generated.UserResponse(
      (b) => b
        ..id = 'user-1'
        ..username = username
        ..email = '$username@example.com'
        ..role = 'student',
    );
    final token = generated.TokenResponse(
      (b) => b
        ..accessToken = 'abcdefghijklmnop-token'
        ..refreshToken = 'refresh-token',
    );
    return AuthSession(user: user, tokens: token);
  }

  @override
  Future<String> requestPasswordReset({required String email}) async {
    return 'Reset link sent to $email';
  }

  @override
  Future<generated.UserResponse> signup({
    required String username,
    required String email,
    required String password,
  }) async {
    return generated.UserResponse(
      (b) => b
        ..id = 'user-2'
        ..username = username
        ..email = email
        ..role = 'student',
    );
  }
}
