import 'package:frontend/network/openapi.dart' as generated;

abstract class CommunicationRepositoryContract {
  Future<generated.CommunicationEvaluationResponse> getCommunicationEvaluation({
    required String sessionId,
  });

  Future<generated.CommunicationEvaluationResponse>
      triggerCommunicationEvaluation({
    required String sessionId,
  });
}

class CommunicationRepository implements CommunicationRepositoryContract {
  CommunicationRepository({required generated.Openapi openapi})
      : _api = openapi.getCommunicationEvaluationApi();

  final generated.CommunicationEvaluationApi _api;

  @override
  Future<generated.CommunicationEvaluationResponse> getCommunicationEvaluation({
    required String sessionId,
  }) async {
    final response = await _api
        .getCommunicationEvaluationSessionsSessionIdCommunicationEvaluationGet(
      sessionId: sessionId,
    );
    return response.data!;
  }

  @override
  Future<generated.CommunicationEvaluationResponse>
      triggerCommunicationEvaluation({
    required String sessionId,
  }) async {
    final response = await _api
        .triggerCommunicationEvaluationSessionsSessionIdCommunicationEvaluationPost(
      sessionId: sessionId,
    );
    return response.data!;
  }
}
