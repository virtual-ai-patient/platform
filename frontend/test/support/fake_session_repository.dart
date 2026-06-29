import 'package:dio/dio.dart';
import 'package:frontend/domains/evaluation/evaluation_repository.dart';
import 'package:frontend/domains/sessions/session_repository.dart';
import 'package:frontend/network/openapi.dart' as g;

class FakeEvaluationRepository implements EvaluationRepositoryContract {
  @override
  Future<g.ScoresResponse> getScores({required String sessionId}) =>
      throw UnimplementedError();

  @override
  Future<g.DebriefResponse> getDebrief({required String sessionId}) =>
      throw UnimplementedError();
}

class FakeSessionRepository implements SessionRepositoryContract {
  FakeSessionRepository({
    this.activeItems = const [],
    this.listError,
    this.onAbandon,
    this.onStartForce,
  });

  final List<g.ActiveSessionItem> activeItems;
  final DioException? listError;
  final void Function(String sessionId)? onAbandon;
  final Future<g.SessionResponse> Function()? onStartForce;

  @override
  Future<List<g.ActiveSessionItem>> listActive() async {
    if (listError != null) throw listError!;
    return activeItems;
  }

  @override
  Future<List<g.SessionResponse>> listCompleted() async {
    if (listError != null) throw listError!;
    return const [];
  }

  @override
  Future<g.ConclusionsResponse> abandonSession({
    required String sessionId,
  }) async {
    onAbandon?.call(sessionId);
    return g.ConclusionsResponse(
      (b) => b
        ..sessionId = sessionId
        ..status = 'abandoned',
    );
  }

  @override
  Future<g.SessionStateResponse> fetchFullState({
    required String sessionId,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<g.SessionStateResponse> getState({
    required String sessionId,
    int cursor = 0,
  }) async {
    throw UnimplementedError();
  }

  @override
  Future<g.SessionResponse> startSession({
    required String caseId,
    bool force = false,
  }) async {
    if (force && onStartForce != null) return onStartForce!();
    return g.SessionResponse(
      (b) => b
        ..sessionId = 'new-session'
        ..caseId = caseId
        ..status = 'active'
        ..createdAt = DateTime.utc(2026)
        ..lastActivityAt = DateTime.utc(2026),
    );
  }

  @override
  Future<g.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
  }) async => throw UnimplementedError();

  @override
  Future<g.AvailableTestsResponse> getAvailableTests({
    required String sessionId,
  }) async => throw UnimplementedError();

  @override
  Future<g.TestResultResponse> orderTest({
    required String sessionId,
    required String testId,
  }) async => throw UnimplementedError();

  @override
  Future<g.ConclusionsResponse> updateConclusions({
    required String sessionId,
    required g.ConclusionsRequest request,
  }) async => throw UnimplementedError();

  @override
  Future<g.ConclusionsResponse> finishSession({
    required String sessionId,
  }) async => throw UnimplementedError();
}

g.ActiveSessionItem fakeActiveSessionItem({required String sessionId}) {
  return g.ActiveSessionItem(
    (b) => b
      ..sessionId = sessionId
      ..caseId = 'CASE-001'
      ..caseTitle = 'Test Case'
      ..createdAt = DateTime.utc(2026, 6, 1)
      ..lastActivityAt = DateTime.utc(2026, 6, 1, 12)
      ..progressSummary.replace(
        g.ProgressSummary(
          (p) => p
            ..turnCount = 4
            ..hasConclusions = true,
        ),
      ),
  );
}
