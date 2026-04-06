//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'investigation_result_request.g.dart';

/// InvestigationResultRequest
///
/// Properties:
/// * [testName]
/// * [resultType]
/// * [value]
/// * [unit]
/// * [referenceRange]
@BuiltValue()
abstract class InvestigationResultRequest
    implements
        Built<InvestigationResultRequest, InvestigationResultRequestBuilder> {
  @BuiltValueField(wireName: r'test_name')
  String get testName;

  @BuiltValueField(wireName: r'result_type')
  InvestigationResultRequestResultTypeEnum get resultType;
  // enum resultTypeEnum {  text_report,  lab_value,  };

  @BuiltValueField(wireName: r'value')
  String get value;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  @BuiltValueField(wireName: r'reference_range')
  String? get referenceRange;

  InvestigationResultRequest._();

  factory InvestigationResultRequest(
          [void updates(InvestigationResultRequestBuilder b)]) =
      _$InvestigationResultRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvestigationResultRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvestigationResultRequest> get serializer =>
      _$InvestigationResultRequestSerializer();
}

class _$InvestigationResultRequestSerializer
    implements PrimitiveSerializer<InvestigationResultRequest> {
  @override
  final Iterable<Type> types = const [
    InvestigationResultRequest,
    _$InvestigationResultRequest
  ];

  @override
  final String wireName = r'InvestigationResultRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvestigationResultRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'test_name';
    yield serializers.serialize(
      object.testName,
      specifiedType: const FullType(String),
    );
    yield r'result_type';
    yield serializers.serialize(
      object.resultType,
      specifiedType: const FullType(InvestigationResultRequestResultTypeEnum),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    if (object.unit != null) {
      yield r'unit';
      yield serializers.serialize(
        object.unit,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.referenceRange != null) {
      yield r'reference_range';
      yield serializers.serialize(
        object.referenceRange,
        specifiedType: const FullType.nullable(String),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InvestigationResultRequest object, {
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
    required InvestigationResultRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'test_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.testName = valueDes;
          break;
        case r'result_type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(InvestigationResultRequestResultTypeEnum),
          ) as InvestigationResultRequestResultTypeEnum;
          result.resultType = valueDes;
          break;
        case r'value':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.value = valueDes;
          break;
        case r'unit':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.unit = valueDes;
          break;
        case r'reference_range':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.referenceRange = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InvestigationResultRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvestigationResultRequestBuilder();
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

class InvestigationResultRequestResultTypeEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'text_report')
  static const InvestigationResultRequestResultTypeEnum textReport =
      _$investigationResultRequestResultTypeEnum_textReport;
  @BuiltValueEnumConst(wireName: r'lab_value')
  static const InvestigationResultRequestResultTypeEnum labValue =
      _$investigationResultRequestResultTypeEnum_labValue;

  static Serializer<InvestigationResultRequestResultTypeEnum> get serializer =>
      _$investigationResultRequestResultTypeEnumSerializer;

  const InvestigationResultRequestResultTypeEnum._(String name) : super(name);

  static BuiltSet<InvestigationResultRequestResultTypeEnum> get values =>
      _$investigationResultRequestResultTypeEnumValues;
  static InvestigationResultRequestResultTypeEnum valueOf(String name) =>
      _$investigationResultRequestResultTypeEnumValueOf(name);
}
