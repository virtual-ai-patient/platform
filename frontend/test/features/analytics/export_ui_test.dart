import 'dart:typed_data';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domains/auth/auth_repository.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/features/analytics/presentation/analytics_screen.dart';
import 'package:frontend/features/analytics/presentation/export_controls.dart';
import 'package:frontend/features/evaluation/presentation/debrief_screen.dart';
import 'package:frontend/network/openapi.dart' as g;

import '../../support/fake_case_response.dart';
import '../../support/fake_communication_repository.dart';
import '../../support/fake_export_repository.dart';

g.UserResponse _user({required String role}) => g.UserResponse(
  (b) => b
    ..id = 'u-1'
    ..username = 'tester'
    ..email = 't@example.com'
    ..role = role,
);

AuthSession _session({required String role}) => AuthSession(
  user: _user(role: role),
  tokens: g.TokenResponse(
    (b) => b
      ..accessToken = 'a'
      ..refreshToken = 'r'
      ..tokenType = 'bearer',
  ),
);

g.DebriefResponse _debrief() => g.DebriefResponse(
  (b) => b
    ..sessionId = 'ses-1'
    ..caseVersion = 1
    ..totalScore = 80
    ..scoreDiagnosis = 20
    ..scoreDiagnostics = 20
    ..scoreTreatment = 20
    ..scoreSafety = 20
    ..scoredAt = DateTime.utc(2026, 6, 1)
    ..findings.replace(BuiltList<g.EvaluationFindingResponse>([]))
    ..referenceSolution.replace(BuiltMap<String, JsonObject?>.of({}))
    ..conclusions.replace(BuiltMap<String, JsonObject?>.of({})),
);

void main() {
  testWidgets('analytics Export visible for educator', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnalyticsScreen(
          session: _session(role: 'educator'),
          exportRepository: FakeExportRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Export'), findsWidgets);
    expect(find.text('Export cohort data'), findsOneWidget);
  });

  testWidgets('analytics Export visible for admin', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnalyticsScreen(
          session: _session(role: 'admin'),
          exportRepository: FakeExportRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Export'), findsWidgets);
  });

  testWidgets('analytics Export hidden for learner', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: AnalyticsScreen(
          session: _session(role: 'learner'),
          exportRepository: FakeExportRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Export'), findsNothing);
    expect(
      find.textContaining('available to educators and admins'),
      findsOneWidget,
    );
  });

  testWidgets('export menu downloads and shows success snackbar', (
    tester,
  ) async {
    final repo = FakeExportRepository();
    String? saved;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnalyticsExportMenuButton(
            exportRepository: repo,
            fileSaver:
                ({
                  required Uint8List bytes,
                  required String filename,
                  required String mimeType,
                }) {
                  saved = filename;
                },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Export'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Sessions (JSON)'));
    await tester.pumpAndSettle();
    expect(repo.calls, contains('sessions:json:all'));
    expect(saved, 'sessions_cohort.json');
    expect(find.textContaining('Downloaded'), findsOneWidget);
  });

  testWidgets('export menu shows explicit error on 403', (tester) async {
    final repo = FakeExportRepository(
      error: DioException(
        requestOptions: RequestOptions(path: '/analytics/export/sessions'),
        response: Response<List<int>>(
          requestOptions: RequestOptions(path: '/analytics/export/sessions'),
          statusCode: 403,
        ),
        type: DioExceptionType.badResponse,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: AnalyticsExportMenuButton(
            exportRepository: repo,
            fileSaver:
                ({
                  required Uint8List bytes,
                  required String filename,
                  required String mimeType,
                }) {},
          ),
        ),
      ),
    );
    await tester.tap(find.text('Export'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Actions — this cohort (CSV)'));
    await tester.pumpAndSettle();
    expect(find.textContaining('permission to export'), findsOneWidget);
  });

  testWidgets('debrief shows Export actions when repository provided', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _Eval(_debrief()),
          communicationRepository: FakeCommunicationRepository(),
          exportRepository: FakeExportRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Export actions'), findsOneWidget);
  });

  testWidgets('debrief hides Export actions without repository', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _Eval(_debrief()),
          communicationRepository: FakeCommunicationRepository(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Export actions'), findsNothing);
  });

  testWidgets('session export downloads with correct filename', (tester) async {
    final okRepo = FakeExportRepository();
    String? saved;
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SessionActionsExportButton(
            sessionId: 'ses-9',
            exportRepository: okRepo,
            fileSaver:
                ({
                  required Uint8List bytes,
                  required String filename,
                  required String mimeType,
                }) {
                  saved = filename;
                },
          ),
        ),
      ),
    );
    await tester.tap(find.text('Export actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Actions (CSV)'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(okRepo.calls, contains('session_actions:ses-9:csv'));
    expect(saved, 'actions_session_ses-9.csv');
    expect(find.textContaining('Downloaded'), findsOneWidget);
  });

  testWidgets('session export shows 403 toast', (tester) async {
    final failRepo = FakeExportRepository(
      error: DioException(
        requestOptions: RequestOptions(path: '/analytics/export/actions'),
        response: Response<List<int>>(
          requestOptions: RequestOptions(path: '/analytics/export/actions'),
          statusCode: 403,
        ),
        type: DioExceptionType.badResponse,
      ),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SessionActionsExportButton(
            sessionId: 'ses-9',
            exportRepository: failRepo,
            fileSaver:
                ({
                  required Uint8List bytes,
                  required String filename,
                  required String mimeType,
                }) {},
          ),
        ),
      ),
    );
    await tester.tap(find.text('Export actions'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Actions (JSON)'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('permission to export'), findsOneWidget);
  });
}

class _Eval implements EvaluationRepositoryContract {
  _Eval(this.debrief);
  final g.DebriefResponse debrief;

  @override
  Future<g.ScoresResponse> getScores({required String sessionId}) {
    throw UnimplementedError();
  }

  @override
  Future<g.DebriefResponse> getDebrief({required String sessionId}) async =>
      debrief;
}
