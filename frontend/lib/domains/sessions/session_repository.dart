import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/openapi.dart' as generated;

abstract class SessionRepositoryContract {
  Future<generated.SessionResponse> startSession({
    required String caseId,
    bool force = false,
  });
  Future<List<generated.ActiveSessionItem>> listActive();
  Future<List<generated.SessionResponse>> listCompleted();
  Future<generated.SessionStateResponse> getState({
    required String sessionId,
    int cursor = 0,
  });
  Future<generated.SessionStateResponse> fetchFullState({
    required String sessionId,
  });
  Future<generated.ConclusionsResponse> abandonSession({
    required String sessionId,
  });
  Future<generated.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
  });
  Future<generated.AvailableTestsResponse> getAvailableTests({
    required String sessionId,
  });
  Future<generated.TestResultResponse> orderTest({
    required String sessionId,
    required String testId,
  });
  Future<generated.ConclusionsResponse> updateConclusions({
    required String sessionId,
    required generated.ConclusionsRequest request,
  });
  Future<generated.ConclusionsResponse> finishSession({
    required String sessionId,
  });
}

class SessionRepository implements SessionRepositoryContract {
  SessionRepository({required generated.Openapi openapi})
      : _api = openapi.getSessionsApi();

  final generated.SessionsApi _api;

  @override
  Future<generated.SessionResponse> startSession({
    required String caseId,
    bool force = false,
  }) async {
    final body = generated.StartSessionRequest((b) => b..caseId = caseId);
    final response = await _api.startSessionSessionsStartPost(
      startSessionRequest: body,
      force: force ? true : false,
    );
    return response.data!;
  }

  @override
  Future<List<generated.ActiveSessionItem>> listActive() async {
    final response = await _api.listActiveSessionsSessionsActiveGet();
    return response.data?.toList(growable: false) ?? const [];
  }

  @override
  Future<List<generated.SessionResponse>> listCompleted() async {
    final response = await _api.listCompletedSessionsSessionsCompletedGet();
    return response.data?.toList(growable: false) ?? const [];
  }

  @override
  Future<generated.SessionStateResponse> getState({
    required String sessionId,
    int cursor = 0,
  }) async {
    final response = await _api.getSessionStateSessionsSessionIdStateGet(
      sessionId: sessionId,
      cursor: cursor,
    );
    return response.data!;
  }

  @override
  Future<generated.SessionStateResponse> fetchFullState({
    required String sessionId,
  }) async {
    var cursor = 0;
    final chatHistory = <generated.ChatMessage>[];
    late generated.SessionStateResponse lastPage;
    while (true) {
      final page = await getState(sessionId: sessionId, cursor: cursor);
      lastPage = page;
      chatHistory.addAll(page.chatHistory);
      final next = page.nextCursor;
      if (next == null) break;
      cursor = next;
    }
    return lastPage.rebuild((b) => b
      ..chatHistory.replace(BuiltList<generated.ChatMessage>(chatHistory))
      ..nextCursor = null);
  }

  @override
  Future<generated.ConclusionsResponse> abandonSession({
    required String sessionId,
  }) async {
    final response = await _api.abandonSessionSessionsSessionIdAbandonPost(
        sessionId: sessionId);
    return response.data!;
  }

  @override
  Future<generated.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
  }) async {
    final body = generated.ChatRequest((b) => b..message = message);
    final response = await _api.chatWithPatientSessionsSessionIdChatPost(
      sessionId: sessionId,
      chatRequest: body,
    );
    return response.data!;
  }

  @override
  Future<generated.AvailableTestsResponse> getAvailableTests({
    required String sessionId,
  }) async {
    final response =
        await _api.availableTestsSessionsSessionIdAvailableTestsGet(
      sessionId: sessionId,
    );
    return response.data!;
  }

  @override
  Future<generated.TestResultResponse> orderTest({
    required String sessionId,
    required String testId,
  }) async {
    final body = generated.OrderTestRequest((b) => b..testId = testId);
    final response = await _api.orderTestEndpointSessionsSessionIdOrderTestPost(
      sessionId: sessionId,
      orderTestRequest: body,
    );
    return response.data!;
  }

  @override
  Future<generated.ConclusionsResponse> updateConclusions({
    required String sessionId,
    required generated.ConclusionsRequest request,
  }) async {
    final response =
        await _api.updateConclusionsSessionsSessionIdConclusionsPatch(
      sessionId: sessionId,
      conclusionsRequest: request,
    );
    return response.data!;
  }

  @override
  Future<generated.ConclusionsResponse> finishSession({
    required String sessionId,
  }) async {
    final response = await _api.finishSessionSessionsSessionIdFinishPost(
      sessionId: sessionId,
    );
    return response.data!;
  }
}
