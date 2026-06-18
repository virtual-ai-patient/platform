//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/evaluation_finding_response.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'debrief_response.g.dart';

/// DebriefResponse
///
/// Properties:
/// * [sessionId]
/// * [caseVersion]
/// * [totalScore]
/// * [scoreDiagnosis]
/// * [scoreDiagnostics]
/// * [scoreTreatment]
/// * [scoreSafety]
/// * [scoredAt]
/// * [findings]
/// * [referenceSolution]
/// * [conclusions]
@BuiltValue()
abstract class DebriefResponse
    implements Built<DebriefResponse, DebriefResponseBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'case_version')
  int get caseVersion;

  @BuiltValueField(wireName: r'total_score')
  num get totalScore;

  @BuiltValueField(wireName: r'score_diagnosis')
  num get scoreDiagnosis;

  @BuiltValueField(wireName: r'score_diagnostics')
  num get scoreDiagnostics;

  @BuiltValueField(wireName: r'score_treatment')
  num get scoreTreatment;

  @BuiltValueField(wireName: r'score_safety')
  num get scoreSafety;

  @BuiltValueField(wireName: r'scored_at')
  DateTime get scoredAt;

  @BuiltValueField(wireName: r'findings')
  BuiltList<EvaluationFindingResponse> get findings;

  @BuiltValueField(wireName: r'reference_solution')
  BuiltMap<String, JsonObject?> get referenceSolution;

  @BuiltValueField(wireName: r'conclusions')
  BuiltMap<String, JsonObject?> get conclusions;

  DebriefResponse._();

  factory DebriefResponse([void updates(DebriefResponseBuilder b)]) =
      _$DebriefResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DebriefResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DebriefResponse> get serializer =>
      _$DebriefResponseSerializer();
}

class _$DebriefResponseSerializer
    implements PrimitiveSerializer<DebriefResponse> {
  @override
  final Iterable<Type> types = const [DebriefResponse, _$DebriefResponse];

  @override
  final String wireName = r'DebriefResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DebriefResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session_id';
    yield serializers.serialize(
      object.sessionId,
      specifiedType: const FullType(String),
    );
    yield r'case_version';
    yield serializers.serialize(
      object.caseVersion,
      specifiedType: const FullType(int),
    );
    yield r'total_score';
    yield serializers.serialize(
      object.totalScore,
      specifiedType: const FullType(num),
    );
    yield r'score_diagnosis';
    yield serializers.serialize(
      object.scoreDiagnosis,
      specifiedType: const FullType(num),
    );
    yield r'score_diagnostics';
    yield serializers.serialize(
      object.scoreDiagnostics,
      specifiedType: const FullType(num),
    );
    yield r'score_treatment';
    yield serializers.serialize(
      object.scoreTreatment,
      specifiedType: const FullType(num),
    );
    yield r'score_safety';
    yield serializers.serialize(
      object.scoreSafety,
      specifiedType: const FullType(num),
    );
    yield r'scored_at';
    yield serializers.serialize(
      object.scoredAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'findings';
    yield serializers.serialize(
      object.findings,
      specifiedType:
          const FullType(BuiltList, [FullType(EvaluationFindingResponse)]),
    );
    yield r'reference_solution';
    yield serializers.serialize(
      object.referenceSolution,
      specifiedType: const FullType(
          BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
    yield r'conclusions';
    yield serializers.serialize(
      object.conclusions,
      specifiedType: const FullType(
          BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DebriefResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object,
            specifiedType: specifiedType)
        .toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required DebriefResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sessionId = valueDes;
          break;
        case r'case_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.caseVersion = valueDes;
          break;
        case r'total_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalScore = valueDes;
          break;
        case r'score_diagnosis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.scoreDiagnosis = valueDes;
          break;
        case r'score_diagnostics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.scoreDiagnostics = valueDes;
          break;
        case r'score_treatment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.scoreTreatment = valueDes;
          break;
        case r'score_safety':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.scoreSafety = valueDes;
          break;
        case r'scored_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.scoredAt = valueDes;
          break;
        case r'findings':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltList, [FullType(EvaluationFindingResponse)]),
          ) as BuiltList<EvaluationFindingResponse>;
          result.findings.replace(valueDes);
          break;
        case r'reference_solution':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.referenceSolution.replace(valueDes);
          break;
        case r'conclusions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>;
          result.conclusions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DebriefResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DebriefResponseBuilder();
    final serializedList = (serialized as Iterable<Object?>).toList();
    final unhandled = <Object?>[];
    _deserializeProperties(
      serializers,
      serialized,
      specifiedType: specifiedType,
      serializedList: serializedList,
      unhandled: unhandled,
      result: result,
    );
    return result.build();
  }
}
