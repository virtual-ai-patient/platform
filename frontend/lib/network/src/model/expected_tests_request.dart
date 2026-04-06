//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'expected_tests_request.g.dart';

/// ExpectedTestsRequest
///
/// Properties:
/// * [mustOrder]
/// * [optional]
/// * [shouldNotOrder]
@BuiltValue()
abstract class ExpectedTestsRequest
    implements Built<ExpectedTestsRequest, ExpectedTestsRequestBuilder> {
  @BuiltValueField(wireName: r'must_order')
  BuiltList<String> get mustOrder;

  @BuiltValueField(wireName: r'optional')
  BuiltList<String> get optional;

  @BuiltValueField(wireName: r'should_not_order')
  BuiltList<String> get shouldNotOrder;

  ExpectedTestsRequest._();

  factory ExpectedTestsRequest([void updates(ExpectedTestsRequestBuilder b)]) =
      _$ExpectedTestsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ExpectedTestsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ExpectedTestsRequest> get serializer =>
      _$ExpectedTestsRequestSerializer();
}

class _$ExpectedTestsRequestSerializer
    implements PrimitiveSerializer<ExpectedTestsRequest> {
  @override
  final Iterable<Type> types = const [
    ExpectedTestsRequest,
    _$ExpectedTestsRequest
  ];

  @override
  final String wireName = r'ExpectedTestsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ExpectedTestsRequest object, {
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
    ExpectedTestsRequest object, {
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
    required ExpectedTestsRequestBuilder result,
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
  ExpectedTestsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ExpectedTestsRequestBuilder();
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
