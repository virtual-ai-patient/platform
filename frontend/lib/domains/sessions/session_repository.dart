import 'package:frontend/network/openapi.dart' as generated;

abstract class SessionRepositoryContract {
  Future<generated.SessionResponse> startSession({required String caseId});
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
}

class SessionRepository implements SessionRepositoryContract {
  SessionRepository({required generated.Openapi openapi})
      : _api = openapi.getSessionsApi();

  final generated.SessionsApi _api;

  @override
  Future<generated.SessionResponse> startSession(
      {required String caseId}) async {
    final body = generated.StartSessionRequest((b) => b..caseId = caseId);
    final response =
        await _api.startSessionSessionsStartPost(startSessionRequest: body);
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
}
