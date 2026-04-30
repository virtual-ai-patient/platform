//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:frontend/network/src/model/acceptable_answer_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'scoring_response.g.dart';

/// ScoringResponse
///
/// Properties:
/// * [weightDiagnosis] 
/// * [weightDiagnostics] 
/// * [weightTreatment] 
/// * [weightSafety] 
/// * [acceptableAnswers] 
/// * [criticalSafetyErrors] 
@BuiltValue()
abstract class ScoringResponse implements Built<ScoringResponse, ScoringResponseBuilder> {
  @BuiltValueField(wireName: r'weight_diagnosis')
  num get weightDiagnosis;

  @BuiltValueField(wireName: r'weight_diagnostics')
  num get weightDiagnostics;

  @BuiltValueField(wireName: r'weight_treatment')
  num get weightTreatment;

  @BuiltValueField(wireName: r'weight_safety')
  num get weightSafety;

  @BuiltValueField(wireName: r'acceptable_answers')
  BuiltList<AcceptableAnswerResponse> get acceptableAnswers;

  @BuiltValueField(wireName: r'critical_safety_errors')
  BuiltList<String> get criticalSafetyErrors;

  ScoringResponse._();

  factory ScoringResponse([void updates(ScoringResponseBuilder b)]) = _$ScoringResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ScoringResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ScoringResponse> get serializer => _$ScoringResponseSerializer();
}

class _$ScoringResponseSerializer implements PrimitiveSerializer<ScoringResponse> {
  @override
  final Iterable<Type> types = const [ScoringResponse, _$ScoringResponse];

  @override
  final String wireName = r'ScoringResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ScoringResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'weight_diagnosis';
    yield serializers.serialize(
      object.weightDiagnosis,
      specifiedType: const FullType(num),
    );
    yield r'weight_diagnostics';
    yield serializers.serialize(
      object.weightDiagnostics,
      specifiedType: const FullType(num),
    );
    yield r'weight_treatment';
    yield serializers.serialize(
      object.weightTreatment,
      specifiedType: const FullType(num),
    );
    yield r'weight_safety';
    yield serializers.serialize(
      object.weightSafety,
      specifiedType: const FullType(num),
    );
    yield r'acceptable_answers';
    yield serializers.serialize(
      object.acceptableAnswers,
      specifiedType: const FullType(BuiltList, [FullType(AcceptableAnswerResponse)]),
    );
    yield r'critical_safety_errors';
    yield serializers.serialize(
      object.criticalSafetyErrors,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ScoringResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ScoringResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'weight_diagnosis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.weightDiagnosis = valueDes;
          break;
        case r'weight_diagnostics':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.weightDiagnostics = valueDes;
          break;
        case r'weight_treatment':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.weightTreatment = valueDes;
          break;
        case r'weight_safety':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.weightSafety = valueDes;
          break;
        case r'acceptable_answers':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(AcceptableAnswerResponse)]),
          ) as BuiltList<AcceptableAnswerResponse>;
          result.acceptableAnswers.replace(valueDes);
          break;
        case r'critical_safety_errors':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.criticalSafetyErrors.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ScoringResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ScoringResponseBuilder();
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

