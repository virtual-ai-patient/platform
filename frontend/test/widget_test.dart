import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/cases/presentation/case_simulation_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;

import 'support/fake_case_response.dart';
import 'support/fake_communication_repository.dart';

void main() {
  testWidgets('CaseSimulationScreen renders with chat UI', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: CaseSimulationScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'test-session-abc123',
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('CASE-001'), findsOneWidget);
    expect(find.byType(Chat), findsOneWidget);
  });

  testWidgets('shows user-facing auth controls', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
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
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
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
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
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

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: LoginScreen(
          authRepository: repo,
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
    );
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

  testWidgets('navigates to case library on successful login', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
          evaluationRepository: _FakeEvaluationRepository(),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
    );

    await tester.enterText(find.widgetWithText(TextField, 'Username'), 'admin');
    await tester.enterText(
      find.widgetWithText(TextField, 'Password'),
      'secret',
    );
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Case Library'), findsOneWidget);
  });
}

class _FakeEvaluationRepository implements EvaluationRepositoryContract {
  @override
  Future<generated.ScoresResponse> getScores({required String sessionId}) {
    throw UnimplementedError();
  }

  @override
  Future<generated.DebriefResponse> getDebrief({required String sessionId}) {
    throw UnimplementedError();
  }
}

class _FakeSessionRepository implements SessionRepositoryContract {
  @override
  Future<generated.SessionResponse> startSession({
    required String caseId,
    bool force = false,
  }) async {
    return generated.SessionResponse(
      (b) => b
        ..sessionId = 'test-session-1'
        ..caseId = caseId
        ..status = 'active'
        ..createdAt = DateTime.utc(2026)
        ..lastActivityAt = DateTime.utc(2026),
    );
  }

  @override
  Future<List<generated.ActiveSessionItem>> listActive() async => [];

  @override
  Future<List<generated.SessionResponse>> listCompleted() async => [];

  @override
  Future<generated.SessionStateResponse> getState({
    required String sessionId,
    int cursor = 0,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<generated.SessionStateResponse> fetchFullState({
    required String sessionId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<generated.ConclusionsResponse> abandonSession({
    required String sessionId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<generated.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    return generated.ChatResponse(
      (b) => b
        ..response = 'Mock AI response'
        ..loggedAt = DateTime.utc(2026),
    );
  }

  @override
  Future<generated.AvailableTestsResponse> getAvailableTests({
    required String sessionId,
  }) async {
    return generated.AvailableTestsResponse(
      (b) => b
        ..tests.add(
          generated.AvailableTestItem(
            (t) => t
              ..testName = 'ECG'
              ..category = 'must_order',
          ),
        ),
    );
  }

  @override
  Future<generated.TestResultResponse> orderTest({
    required String sessionId,
    required String testId,
  }) async {
    return generated.TestResultResponse(
      (b) => b
        ..testName = testId
        ..resultType = 'text_report'
        ..value = 'Normal / No significant findings.'
        ..unit = null
        ..referenceRange = null
        ..isNormalDefault = true,
    );
  }

  @override
  Future<generated.ConclusionsResponse> updateConclusions({
    required String sessionId,
    required generated.ConclusionsRequest request,
  }) async {
    return generated.ConclusionsResponse(
      (b) => b
        ..sessionId = sessionId
        ..status = 'active',
    );
  }

  @override
  Future<generated.ConclusionsResponse> finishSession({
    required String sessionId,
  }) async {
    return generated.ConclusionsResponse(
      (b) => b
        ..sessionId = sessionId
        ..status = 'completed',
    );
  }
}

class _FakeCaseRepository implements CaseRepositoryContract {
  @override
  Future<List<generated.CaseResponse>> listCases({String? status}) async => [];

  @override
  Future<generated.CaseResponse> createCase(
    generated.CreateCaseRequest request,
  ) async {
    throw UnimplementedError();
  }

  @override
  Future<generated.CaseResponse> updateCase({
    required String id,
    required generated.UpdateCaseRequest updateCaseRequest,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteCase({required String id}) async {
    throw UnimplementedError();
  }
}

class _FakeAuthRepository implements AuthRepositoryContract {
  _FakeAuthRepository({this.loginError});

  final Object? loginError;

  @override
  Future<void> logout() async {}

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
