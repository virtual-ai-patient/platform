import 'package:frontend/network/openapi.dart' as generated;

abstract class SessionRepositoryContract {
  Future<generated.SessionResponse> startSession({required String caseId});
  Future<generated.ChatResponse> sendMessage({
    required String sessionId,
    required String message,
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
}
