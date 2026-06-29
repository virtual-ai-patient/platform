import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/sessions/presentation/duplicate_start_dialog.dart';
import 'package:frontend/features/sessions/presentation/unfinished_sessions_sheet.dart';
import 'package:frontend/domains/sessions/session_start_conflict.dart';
import 'package:frontend/network/openapi.dart' as g;

import '../../support/fake_case_response.dart';
import '../../support/fake_communication_repository.dart';
import '../../support/fake_session_repository.dart';

void main() {
  testWidgets('unfinished sheet not shown when list is empty', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showUnfinishedSessionsSheet(
                    context: context,
                    sessionRepository: FakeSessionRepository(),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Unfinished sessions'), findsNothing);
    expect(find.text('Pick up where you left off'), findsNothing);
  });

  testWidgets('unfinished sheet shows populated list', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showUnfinishedSessionsSheet(
                    context: context,
                    sessionRepository: FakeSessionRepository(
                      activeItems: [fakeActiveSessionItem(sessionId: 's-1')],
                    ),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Pick up where you left off'), findsOneWidget);
    expect(find.text('Test Case'), findsOneWidget);
    expect(find.text('4 turns'), findsOneWidget);
    expect(find.text('Conclusions started'), findsOneWidget);
    expect(find.text('Resume'), findsOneWidget);
    expect(find.text('In progress'), findsOneWidget);
  });

  testWidgets('unfinished sheet resume navigates on tap', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showUnfinishedSessionsSheet(
                    context: context,
                    sessionRepository: FakeSessionRepository(
                      activeItems: [fakeActiveSessionItem(sessionId: 's-1')],
                    ),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Resume'));
    await tester.pump();
    await tester.pump(const Duration(seconds: 1));
    await tester.pumpAndSettle();
    expect(find.byType(CircularProgressIndicator), findsNothing);
  });

  testWidgets('unfinished sheet abandon removes row', (tester) async {
    String? abandoned;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showUnfinishedSessionsSheet(
                    context: context,
                    sessionRepository: FakeSessionRepository(
                      activeItems: [fakeActiveSessionItem(sessionId: 's-1')],
                      onAbandon: (id) => abandoned = id,
                    ),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Abandon'));
    await tester.pumpAndSettle();
    expect(abandoned, 's-1');
    expect(find.text('Pick up where you left off'), findsNothing);
    expect(find.text('Pick up where you left off'), findsNothing);
  });

  testWidgets('unfinished sheet shows 403 error', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showUnfinishedSessionsSheet(
                    context: context,
                    sessionRepository: FakeSessionRepository(
                      listError: DioException(
                        requestOptions: RequestOptions(
                          path: '/sessions/active',
                        ),
                        response: Response<void>(
                          requestOptions: RequestOptions(
                            path: '/sessions/active',
                          ),
                          statusCode: 403,
                        ),
                        type: DioExceptionType.badResponse,
                      ),
                    ),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Access denied'), findsOneWidget);
  });

  testWidgets('duplicate start dialog shows actions', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showDuplicateStartDialog(
                    context: context,
                    caseItem: fakeCaseResponse(),
                    conflict: const SessionStartConflict(
                      existingSessionId: 'existing-1',
                    ),
                    sessionRepository: FakeSessionRepository(),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.textContaining('unfinished session'), findsOneWidget);
    expect(find.text('Resume existing'), findsOneWidget);
    expect(find.text('Start fresh'), findsOneWidget);
  });

  testWidgets('duplicate start dialog start fresh calls force start', (
    tester,
  ) async {
    var forceCalled = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Center(
                child: FilledButton(
                  onPressed: () => showDuplicateStartDialog(
                    context: context,
                    caseItem: fakeCaseResponse(),
                    conflict: const SessionStartConflict(
                      existingSessionId: 'existing-1',
                    ),
                    sessionRepository: FakeSessionRepository(
                      onStartForce: () async {
                        forceCalled = true;
                        return g.SessionResponse(
                          (b) => b
                            ..sessionId = 'fresh-1'
                            ..caseId = 'CASE-001'
                            ..status = 'active'
                            ..createdAt = DateTime.utc(2026)
                            ..lastActivityAt = DateTime.utc(2026),
                        );
                      },
                    ),
                    evaluationRepository: FakeEvaluationRepository(),
                    communicationRepository: FakeCommunicationRepository(),
                  ),
                  child: const Text('Open'),
                ),
              ),
            );
          },
        ),
      ),
    );
    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Start fresh'));
    await tester.pumpAndSettle();
    expect(forceCalled, isTrue);
  });
}
