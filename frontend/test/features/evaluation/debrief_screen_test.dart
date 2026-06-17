import 'dart:async';

import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/features/evaluation/presentation/debrief_screen.dart';
import 'package:frontend/network/openapi.dart' as g;

import '../../support/fake_case_response.dart';

g.DebriefResponse _minimalDebrief({
  BuiltList<g.EvaluationFindingResponse>? findings,
}) {
  return g.DebriefResponse((b) => b
    ..sessionId = 'ses-1'
    ..caseVersion = 1
    ..totalScore = 88
    ..scoreDiagnosis = 22
    ..scoreDiagnostics = 22
    ..scoreTreatment = 22
    ..scoreSafety = 22
    ..scoredAt = DateTime.utc(2026, 6, 1, 12)
    ..findings.replace(findings ?? BuiltList<g.EvaluationFindingResponse>([]))
    ..referenceSolution.replace(BuiltMap<String, JsonObject?>.of({}))
    ..conclusions.replace(BuiltMap<String, JsonObject?>.of({})));
}

class _FakeEval implements EvaluationRepositoryContract {
  _FakeEval({
    this.debrief,
    this.error,
    this.awaitGate,
  });

  final g.DebriefResponse? debrief;
  final DioException? error;
  final Completer<void>? awaitGate;

  @override
  Future<g.ScoresResponse> getScores({required String sessionId}) async {
    throw UnimplementedError();
  }

  @override
  Future<g.DebriefResponse> getDebrief({required String sessionId}) async {
    if (awaitGate != null) {
      await awaitGate!.future;
    }
    if (error != null) {
      throw error!;
    }
    return debrief!;
  }
}

void main() {
  testWidgets('shows loading then success', (WidgetTester tester) async {
    final gate = Completer<void>();
    final repo = _FakeEval(
      debrief: _minimalDebrief(),
      awaitGate: gate,
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: repo,
        ),
      ),
    );
    await tester.pump();
    expect(find.textContaining('Loading evaluation'), findsOneWidget);
    gate.complete();
    await tester.pumpAndSettle();
    expect(find.textContaining('Total: 88'), findsOneWidget);
    expect(find.text('Scores'), findsOneWidget);
  });

  testWidgets('success with empty findings', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _FakeEval(debrief: _minimalDebrief()),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(
      find.text('No findings recorded for this run.'),
      findsOneWidget,
    );
  });

  testWidgets('403 panel', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _FakeEval(
            error: DioException(
              requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
              response: Response<dynamic>(
                requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
                statusCode: 403,
                data: {'detail': 'You do not have access to this evaluation'},
              ),
              type: DioExceptionType.badResponse,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining("don't have access"), findsOneWidget);
  });

  testWidgets('404 panel', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _FakeEval(
            error: DioException(
              requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
              response: Response<dynamic>(
                requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
                statusCode: 404,
                data: {'detail': "Session 'x' not found"},
              ),
              type: DioExceptionType.badResponse,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Session not found.'), findsOneWidget);
  });

  testWidgets('409 session not finished', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _FakeEval(
            error: DioException(
              requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
              response: Response<dynamic>(
                requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
                statusCode: 409,
                data: {'detail': 'Session is not finished'},
              ),
              type: DioExceptionType.badResponse,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('not finished yet'), findsOneWidget);
  });

  testWidgets('409 evaluation not yet available', (WidgetTester tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: DebriefScreen(
          caseItem: fakeCaseResponse(),
          sessionId: 'ses-1',
          evaluationRepository: _FakeEval(
            error: DioException(
              requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
              response: Response<dynamic>(
                requestOptions: RequestOptions(path: '/sessions/ses-1/debrief'),
                statusCode: 409,
                data: {'detail': 'Evaluation not yet available'},
              ),
              type: DioExceptionType.badResponse,
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.textContaining('still in progress'), findsOneWidget);
  });
}
