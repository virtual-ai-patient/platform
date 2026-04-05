//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'expected_tests_response.g.dart';

/// ExpectedTestsResponse
///
/// Properties:
/// * [mustOrder] 
/// * [optional] 
/// * [shouldNotOrder] 
@BuiltValue()
abstract class ExpectedTestsResponse implements Built<ExpectedTestsResponse, ExpectedTestsResponseBuilder> {
  @BuiltValueField(wireName: r'must_order')
  BuiltList<String> get mustOrder;

  @BuiltValueField(wireName: r'optional')
  BuiltList<String> get optional;

  @BuiltValueField(wireName: r'should_not_order')
  BuiltList<String> get shouldNotOrder;

  ExpectedTestsResponse._();

  factory ExpectedTestsResponse([void updates(ExpectedTestsResponseBuilder b)]) = _$ExpectedTestsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExpectedTestsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExpectedTestsResponse> get serializer => _$ExpectedTestsResponseSerializer();
}

class _$ExpectedTestsResponseSerializer implements PrimitiveSerializer<ExpectedTestsResponse> {
  @override
  final Iterable<Type> types = const [ExpectedTestsResponse, _$ExpectedTestsResponse];

  @override
  final String wireName = r'ExpectedTestsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExpectedTestsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'must_order';
    yield serializers.serialize(
      object.mustOrder,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'optional';
    yield serializers.serialize(
      object.optional,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'should_not_order';
    yield serializers.serialize(
      object.shouldNotOrder,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ExpectedTestsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ExpectedTestsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'must_order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.mustOrder.replace(valueDes);
          break;
        case r'optional':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.optional.replace(valueDes);
          break;
        case r'should_not_order':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.shouldNotOrder.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ExpectedTestsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExpectedTestsResponseBuilder();
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

