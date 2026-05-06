//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/medication.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'treatment_plan.g.dart';

/// TreatmentPlan
///
/// Properties:
/// * [medications]
/// * [nonPharmacological]
/// * [referrals]
/// * [followUp]
@BuiltValue()
abstract class TreatmentPlan
    implements Built<TreatmentPlan, TreatmentPlanBuilder> {
  @BuiltValueField(wireName: r'medications')
  BuiltList<Medication>? get medications;

  @BuiltValueField(wireName: r'non_pharmacological')
  BuiltList<String>? get nonPharmacological;

  @BuiltValueField(wireName: r'referrals')
  BuiltList<String>? get referrals;

  @BuiltValueField(wireName: r'follow_up')
  BuiltList<String>? get followUp;

  TreatmentPlan._();

  factory TreatmentPlan([void updates(TreatmentPlanBuilder b)]) =
      _$TreatmentPlan;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TreatmentPlanBuilder b) => b
    ..medications = ListBuilder()
    ..nonPharmacological = ListBuilder()
    ..referrals = ListBuilder()
    ..followUp = ListBuilder();

  @BuiltValueSerializer(custom: true)
  static Serializer<TreatmentPlan> get serializer =>
      _$TreatmentPlanSerializer();
}

class _$TreatmentPlanSerializer implements PrimitiveSerializer<TreatmentPlan> {
  @override
  final Iterable<Type> types = const [TreatmentPlan, _$TreatmentPlan];

  @override
  final String wireName = r'TreatmentPlan';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TreatmentPlan object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.medications != null) {
      yield r'medications';
      yield serializers.serialize(
        object.medications,
        specifiedType: const FullType(BuiltList, [FullType(Medication)]),
      );
    }
    if (object.nonPharmacological != null) {
      yield r'non_pharmacological';
      yield serializers.serialize(
        object.nonPharmacological,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.referrals != null) {
      yield r'referrals';
      yield serializers.serialize(
        object.referrals,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.followUp != null) {
      yield r'follow_up';
      yield serializers.serialize(
        object.followUp,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    TreatmentPlan object, {
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
    required TreatmentPlanBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'medications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(Medication)]),
          ) as BuiltList<Medication>;
          result.medications.replace(valueDes);
          break;
        case r'non_pharmacological':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.nonPharmacological.replace(valueDes);
          break;
        case r'referrals':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.referrals.replace(valueDes);
          break;
        case r'follow_up':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.followUp.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TreatmentPlan deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TreatmentPlanBuilder();
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
