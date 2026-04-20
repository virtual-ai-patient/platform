import 'package:built_collection/built_collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart';
import 'package:dio/dio.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/cases/case_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/features/auth/presentation/login_screen.dart';
import 'package:frontend/features/cases/presentation/case_simulation_screen.dart';
import 'package:frontend/network/openapi.dart' as generated;

generated.CaseResponse _fakeCaseResponse() => generated.CaseResponse((b) => b
  ..id = 'id-1'
  ..caseId = 'CASE-001'
  ..status = 'published'
  ..version = 1
  ..createdBy = 'educator'
  ..title = 'Test Case'
  ..language = 'en'
  ..difficulty = 'easy'
  ..specialty = 'Cardiology'
  ..tags = ListBuilder<String>(['tag1'])
  ..age = 45
  ..sex = 'male'
  ..persona = 'Test persona'
  ..tonePresets = ListBuilder<String>(['calm'])
  ..chiefComplaint = 'Chest pain'
  ..historyOfPresentIllness = 'Patient reports...'
  ..keyHistoryPoints.replace(generated.KeyHistoryPointsResponse((k) => k
    ..mustAsk = ListBuilder<String>(['q1'])
    ..niceToAsk = ListBuilder<String>(['q2'])
    ..redFlags = ListBuilder<String>(['rf1'])))
  ..finalDiagnosis = 'STEMI'
  ..differential = ListBuilder<String>(['ACS'])
  ..investigations.replace(generated.InvestigationsResponse((i) => i
    ..catalogHints = ListBuilder<String>(['ECG'])
    ..expected.replace(generated.ExpectedTestsResponse((e) => e
      ..mustOrder = ListBuilder<String>(['ECG'])
      ..optional = ListBuilder<String>(['CXR'])
      ..shouldNotOrder = ListBuilder<String>()))
    ..results = ListBuilder<generated.InvestigationResultResponse>()))
  ..management.replace(generated.ManagementResponse((m) => m
    ..diagnosticPlan = ListBuilder<String>(['ECG'])
    ..treatmentPlan = ListBuilder<String>(['Aspirin'])
    ..contraindications = ListBuilder<String>()
    ..followUp = ListBuilder<String>(['Cardiology'])))
  ..scoring.replace(generated.ScoringResponse((s) => s
    ..weightDiagnosis = 0.3
    ..weightDiagnostics = 0.3
    ..weightTreatment = 0.2
    ..weightSafety = 0.2
    ..acceptableAnswers = ListBuilder<generated.AcceptableAnswerResponse>()
    ..criticalSafetyErrors = ListBuilder<String>())));

void main() {
  testWidgets('CaseSimulationScreen renders with chat UI',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: CaseSimulationScreen(
          caseItem: _fakeCaseResponse(),
          sessionId: 'test-session-abc123',
          sessionRepository: _FakeSessionRepository(),
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
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
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
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
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
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
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
        home: LoginScreen(
          authRepository: repo,
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
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

  testWidgets('navigates to case library on successful login',
      (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: LoginScreen(
          authRepository: _FakeAuthRepository(),
          caseRepository: _FakeCaseRepository(),
          sessionRepository: _FakeSessionRepository(),
        ),
      ),
    );

    await tester.enterText(find.widgetWithText(TextField, 'Username'), 'admin');
    await tester.enterText(
        find.widgetWithText(TextField, 'Password'), 'secret');
    await tester.ensureVisible(find.text('Log in'));
    await tester.tap(find.text('Log in'));
    await tester.pumpAndSettle();

    expect(find.text('Case Library'), findsOneWidget);
  });
}

class _FakeSessionRepository implements SessionRepositoryContract {
  @override
  Future<generated.SessionResponse> startSession(
      {required String caseId}) async {
    return generated.SessionResponse((b) => b
      ..sessionId = 'test-session-1'
      ..caseId = caseId
      ..status = 'active'
      ..createdAt = DateTime.utc(2026));
  }

  @override
  Future<generated.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    return generated.ChatResponse((b) => b
      ..response = 'Mock AI response'
      ..loggedAt = DateTime.utc(2026));
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
