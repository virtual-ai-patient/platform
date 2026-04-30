//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'test_result_response.g.dart';

/// TestResultResponse
///
/// Properties:
/// * [testName] 
/// * [resultType] 
/// * [value] 
/// * [unit] 
/// * [referenceRange] 
/// * [isNormalDefault] 
@BuiltValue()
abstract class TestResultResponse implements Built<TestResultResponse, TestResultResponseBuilder> {
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

  @BuiltValueField(wireName: r'is_normal_default')
  bool get isNormalDefault;

  TestResultResponse._();

  factory TestResultResponse([void updates(TestResultResponseBuilder b)]) = _$TestResultResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(TestResultResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<TestResultResponse> get serializer => _$TestResultResponseSerializer();
}

class _$TestResultResponseSerializer implements PrimitiveSerializer<TestResultResponse> {
  @override
  final Iterable<Type> types = const [TestResultResponse, _$TestResultResponse];

  @override
  final String wireName = r'TestResultResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    TestResultResponse object, {
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
    yield r'is_normal_default';
    yield serializers.serialize(
      object.isNormalDefault,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    TestResultResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required TestResultResponseBuilder result,
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
        case r'is_normal_default':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(bool),
          ) as bool;
          result.isNormalDefault = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  TestResultResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = TestResultResponseBuilder();
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

