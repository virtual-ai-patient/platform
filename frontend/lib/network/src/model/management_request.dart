//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'management_request.g.dart';

/// ManagementRequest
///
/// Properties:
/// * [diagnosticPlan]
/// * [treatmentPlan]
/// * [contraindications]
/// * [followUp]
@BuiltValue()
abstract class ManagementRequest
    implements Built<ManagementRequest, ManagementRequestBuilder> {
  @BuiltValueField(wireName: r'diagnostic_plan')
  BuiltList<String> get diagnosticPlan;

  @BuiltValueField(wireName: r'treatment_plan')
  BuiltList<String> get treatmentPlan;

  @BuiltValueField(wireName: r'contraindications')
  BuiltList<String> get contraindications;

  @BuiltValueField(wireName: r'follow_up')
  BuiltList<String> get followUp;

  ManagementRequest._();

  factory ManagementRequest([void updates(ManagementRequestBuilder b)]) =
      _$ManagementRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ManagementRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ManagementRequest> get serializer =>
      _$ManagementRequestSerializer();
}

class _$ManagementRequestSerializer
    implements PrimitiveSerializer<ManagementRequest> {
  @override
  final Iterable<Type> types = const [ManagementRequest, _$ManagementRequest];

  @override
  final String wireName = r'ManagementRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ManagementRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'diagnostic_plan';
    yield serializers.serialize(
      object.diagnosticPlan,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'treatment_plan';
    yield serializers.serialize(
      object.treatmentPlan,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'contraindications';
    yield serializers.serialize(
      object.contraindications,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'follow_up';
    yield serializers.serialize(
      object.followUp,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ManagementRequest object, {
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
    required ManagementRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'diagnostic_plan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.diagnosticPlan.replace(valueDes);
          break;
        case r'treatment_plan':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.treatmentPlan.replace(valueDes);
          break;
        case r'contraindications':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.contraindications.replace(valueDes);
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
  ManagementRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ManagementRequestBuilder();
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
