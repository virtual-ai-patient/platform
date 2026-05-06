//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/differential_diagnosis_item.dart';
import 'package:frontend/network/src/model/treatment_plan.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'conclusions_request.g.dart';

/// ConclusionsRequest
///
/// Properties:
/// * [differentialDiagnoses]
/// * [finalDiagnosis]
/// * [treatmentPlan]
@BuiltValue()
abstract class ConclusionsRequest
    implements Built<ConclusionsRequest, ConclusionsRequestBuilder> {
  @BuiltValueField(wireName: r'differential_diagnoses')
  BuiltList<DifferentialDiagnosisItem>? get differentialDiagnoses;

  @BuiltValueField(wireName: r'final_diagnosis')
  String? get finalDiagnosis;

  @BuiltValueField(wireName: r'treatment_plan')
  TreatmentPlan? get treatmentPlan;

  ConclusionsRequest._();

  factory ConclusionsRequest([void updates(ConclusionsRequestBuilder b)]) =
      _$ConclusionsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConclusionsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConclusionsRequest> get serializer =>
      _$ConclusionsRequestSerializer();
}

class _$ConclusionsRequestSerializer
    implements PrimitiveSerializer<ConclusionsRequest> {
  @override
  final Iterable<Type> types = const [ConclusionsRequest, _$ConclusionsRequest];

  @override
  final String wireName = r'ConclusionsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConclusionsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.differentialDiagnoses != null) {
      yield r'differential_diagnoses';
      yield serializers.serialize(
        object.differentialDiagnoses,
        specifiedType: const FullType.nullable(
            BuiltList, [FullType(DifferentialDiagnosisItem)]),
      );
    }
    if (object.finalDiagnosis != null) {
      yield r'final_diagnosis';
      yield serializers.serialize(
        object.finalDiagnosis,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.treatmentPlan != null) {
      yield r'treatment_plan';
      yield serializers.serialize(
        object.treatmentPlan,
        specifiedType: const FullType.nullable(TreatmentPlan),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    ConclusionsRequest object, {
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
    required ConclusionsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'differential_diagnoses':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(
                BuiltList, [FullType(DifferentialDiagnosisItem)]),
          ) as BuiltList<DifferentialDiagnosisItem>?;
          if (valueDes == null) continue;
          result.differentialDiagnoses.replace(valueDes);
          break;
        case r'final_diagnosis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.finalDiagnosis = valueDes;
          break;
        case r'treatment_plan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(TreatmentPlan),
          ) as TreatmentPlan?;
          if (valueDes == null) continue;
          result.treatmentPlan.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ConclusionsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConclusionsRequestBuilder();
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
