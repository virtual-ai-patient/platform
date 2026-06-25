import 'package:built_collection/built_collection.dart';
import 'package:frontend/domains/evaluation/communication_repository.dart';
import 'package:frontend/network/openapi.dart' as g;

class FakeCommunicationRepository implements CommunicationRepositoryContract {
  FakeCommunicationRepository({
    this.evaluation,
    this.getError,
    this.triggerError,
    this.onGet,
    this.onTrigger,
  });

  final g.CommunicationEvaluationResponse? evaluation;
  final Object? getError;
  final Object? triggerError;
  final Future<void> Function()? onGet;
  final Future<void> Function()? onTrigger;

  int getCallCount = 0;
  int triggerCallCount = 0;

  @override
  Future<g.CommunicationEvaluationResponse> getCommunicationEvaluation({
    required String sessionId,
  }) async {
    getCallCount++;
    if (onGet != null) await onGet!();
    if (getError != null) throw getError!;
    return evaluation ?? fakeCommunicationEvaluation(sessionId: sessionId);
  }

  @override
  Future<g.CommunicationEvaluationResponse> triggerCommunicationEvaluation({
    required String sessionId,
  }) async {
    triggerCallCount++;
    if (onTrigger != null) await onTrigger!();
    if (triggerError != null) throw triggerError!;
    return evaluation ?? fakeCommunicationEvaluation(sessionId: sessionId);
  }
}

g.CommunicationEvaluationResponse fakeCommunicationEvaluation({
  required String sessionId,
}) {
  return g.CommunicationEvaluationResponse((b) => b
    ..sessionId = sessionId
    ..model = 'mock'
    ..promptVersion = 'v1'
    ..totalScore = 76
    ..createdAt = DateTime.utc(2026, 6, 19, 12)
    ..criteria.replace(BuiltList<g.CommunicationCriterionResponse>([
      _criterion('open_ended_questions', 4),
      _criterion('empathy', 4),
      _criterion('structured_history', 3),
      _criterion('closing_the_loop', 4),
      _criterion('no_leading_questions', 3),
    ])));
}

g.CommunicationCriterionResponse _criterion(String key, int score) {
  return g.CommunicationCriterionResponse((b) => b
    ..criterion = key
    ..score = score
    ..rationale = 'Feedback for $key.'
    ..quote = 'Can you tell me more about that?');
}
