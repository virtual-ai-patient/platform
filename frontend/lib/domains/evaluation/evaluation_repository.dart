import 'package:frontend/network/openapi.dart' as generated;

abstract class EvaluationRepositoryContract {
  Future<generated.ScoresResponse> getScores({required String sessionId});
  Future<generated.DebriefResponse> getDebrief({required String sessionId});
}

class EvaluationRepository implements EvaluationRepositoryContract {
  EvaluationRepository({required generated.Openapi openapi})
    : _api = openapi.getEvaluationApi();

  final generated.EvaluationApi _api;

  @override
  Future<generated.ScoresResponse> getScores({
    required String sessionId,
  }) async {
    final response = await _api.getScoresSessionsSessionIdScoresGet(
      sessionId: sessionId,
    );
    return response.data!;
  }

  @override
  Future<generated.DebriefResponse> getDebrief({
    required String sessionId,
  }) async {
    final response = await _api.getDebriefSessionsSessionIdDebriefGet(
      sessionId: sessionId,
    );
    return response.data!;
  }
}
