//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'investigation_result_response.g.dart';

/// InvestigationResultResponse
///
/// Properties:
/// * [testName] 
/// * [resultType] 
/// * [value] 
/// * [unit] 
/// * [referenceRange] 
@BuiltValue()
abstract class InvestigationResultResponse implements Built<InvestigationResultResponse, InvestigationResultResponseBuilder> {
  @BuiltValueField(wireName: r'test_name')
  String get testName;

  @BuiltValueField(wireName: r'result_type')
  String get resultType;

  @BuiltValueField(wireName: r'value')
  String get value;

  @BuiltValueField(wireName: r'unit')
  String? get unit;

  @BuiltValueField(wireName: r'reference_range')
  String? get referenceRange;

  InvestigationResultResponse._();

  factory InvestigationResultResponse([void updates(InvestigationResultResponseBuilder b)]) = _$InvestigationResultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvestigationResultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvestigationResultResponse> get serializer => _$InvestigationResultResponseSerializer();
}

class _$InvestigationResultResponseSerializer implements PrimitiveSerializer<InvestigationResultResponse> {
  @override
  final Iterable<Type> types = const [InvestigationResultResponse, _$InvestigationResultResponse];

  @override
  final String wireName = r'InvestigationResultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvestigationResultResponse object, {
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
      specifiedType: const FullType(String),
    );
    yield r'value';
    yield serializers.serialize(
      object.value,
      specifiedType: const FullType(String),
    );
    yield r'unit';
    yield object.unit == null ? null : serializers.serialize(
      object.unit,
      specifiedType: const FullType.nullable(String),
    );
    yield r'reference_range';
    yield object.referenceRange == null ? null : serializers.serialize(
      object.referenceRange,
      specifiedType: const FullType.nullable(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InvestigationResultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvestigationResultResponseBuilder result,
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
            specifiedType: const FullType(String),
          ) as String;
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
  InvestigationResultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvestigationResultResponseBuilder();
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

