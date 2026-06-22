import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/features/evaluation/presentation/communication_panel.dart';
import '../../support/fake_communication_repository.dart';

void main() {
  testWidgets('shows analyzing skeleton while loading', (tester) async {
    final gate = Completer<void>();
    final repo = FakeCommunicationRepository(
      onGet: () => gate.future,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Scaffold(
          body: CommunicationPanel(
            sessionId: 'ses-1',
            communicationRepository: repo,
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.textContaining('Analyzing your conversation'), findsNothing);
    expect(find.textContaining('Checking for saved'), findsOneWidget);

    gate.complete();
    await tester.pumpAndSettle();
    expect(find.text('76'), findsOneWidget);
  });

  testWidgets('success shows all criteria with quote', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Scaffold(
          body: CommunicationPanel(
            sessionId: 'ses-1',
            communicationRepository: FakeCommunicationRepository(),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Communication coaching'), findsOneWidget);
    expect(find.text('76'), findsOneWidget);
    expect(find.text('Open-ended questions'), findsOneWidget);
    expect(find.text('Empathy'), findsOneWidget);
    expect(find.text('Can you tell me more about that?'), findsWidgets);
  });

  testWidgets('GET 409 not yet available triggers POST once', (tester) async {
    final triggerGate = Completer<void>();
    final repo = FakeCommunicationRepository(
      getError: DioException(
        requestOptions: RequestOptions(path: '/x'),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/x'),
          statusCode: 409,
          data: {'detail': 'Communication evaluation not yet available'},
        ),
        type: DioExceptionType.badResponse,
      ),
      onTrigger: () => triggerGate.future,
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Scaffold(
          body: CommunicationPanel(
            sessionId: 'ses-1',
            communicationRepository: repo,
          ),
        ),
      ),
    );
    await tester.pump();
    expect(find.textContaining('reviewing your doctor'), findsOneWidget);
    triggerGate.complete();
    await tester.pumpAndSettle();

    expect(repo.triggerCallCount, 1);
    expect(find.text('76'), findsOneWidget);
  });

  testWidgets('shows 403 access denied', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Scaffold(
          body: CommunicationPanel(
            sessionId: 'ses-1',
            communicationRepository: FakeCommunicationRepository(
              getError: DioException(
                requestOptions: RequestOptions(path: '/x'),
                response: Response<void>(
                  requestOptions: RequestOptions(path: '/x'),
                  statusCode: 403,
                ),
                type: DioExceptionType.badResponse,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Access denied'), findsOneWidget);
  });

  testWidgets('502 retry triggers POST again', (tester) async {
    var triggers = 0;
    final repo = FakeCommunicationRepository(
      getError: DioException(
        requestOptions: RequestOptions(path: '/x'),
        response: Response<dynamic>(
          requestOptions: RequestOptions(path: '/x'),
          statusCode: 409,
          data: {'detail': 'Communication evaluation not yet available'},
        ),
        type: DioExceptionType.badResponse,
      ),
      onTrigger: () async {
        triggers++;
        if (triggers == 1) {
          throw DioException(
            requestOptions: RequestOptions(path: '/x'),
            response: Response<void>(
              requestOptions: RequestOptions(path: '/x'),
              statusCode: 502,
            ),
            type: DioExceptionType.badResponse,
          );
        }
      },
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: ThemeData(useMaterial3: false),
        home: Scaffold(
          body: CommunicationPanel(
            sessionId: 'ses-1',
            communicationRepository: repo,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Communication coach unavailable'), findsOneWidget);

    await tester.tap(find.text('Retry analysis'));
    await tester.pumpAndSettle();
    expect(repo.triggerCallCount, 2);
    expect(find.text('76'), findsOneWidget);
  });
}
