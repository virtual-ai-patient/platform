//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scores_response.g.dart';

/// ScoresResponse
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
@BuiltValue()
abstract class ScoresResponse
    implements Built<ScoresResponse, ScoresResponseBuilder> {
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

  ScoresResponse._();

  factory ScoresResponse([void updates(ScoresResponseBuilder b)]) =
      _$ScoresResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoresResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoresResponse> get serializer =>
      _$ScoresResponseSerializer();
}

class _$ScoresResponseSerializer
    implements PrimitiveSerializer<ScoresResponse> {
  @override
  final Iterable<Type> types = const [ScoresResponse, _$ScoresResponse];

  @override
  final String wireName = r'ScoresResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoresResponse object, {
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
  }

  @override
  Object serialize(
    Serializers serializers,
    ScoresResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScoresResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session_id':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.sessionId = valueDes;
          break;
        case r'case_version':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.caseVersion = valueDes;
          break;
        case r'total_score':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.totalScore = valueDes;
          break;
        case r'score_diagnosis':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.scoreDiagnosis = valueDes;
          break;
        case r'score_diagnostics':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.scoreDiagnostics = valueDes;
          break;
        case r'score_treatment':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.scoreTreatment = valueDes;
          break;
        case r'score_safety':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(num))
                  as num;
          result.scoreSafety = valueDes;
          break;
        case r'scored_at':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.scoredAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScoresResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoresResponseBuilder();
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
