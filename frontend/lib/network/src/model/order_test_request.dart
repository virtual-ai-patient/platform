//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'order_test_request.g.dart';

/// OrderTestRequest
///
/// Properties:
/// * [testId]
@BuiltValue()
abstract class OrderTestRequest
    implements Built<OrderTestRequest, OrderTestRequestBuilder> {
  @BuiltValueField(wireName: r'test_id')
  String get testId;

  OrderTestRequest._();

  factory OrderTestRequest([void updates(OrderTestRequestBuilder b)]) =
      _$OrderTestRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(OrderTestRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<OrderTestRequest> get serializer =>
      _$OrderTestRequestSerializer();
}

class _$OrderTestRequestSerializer
    implements PrimitiveSerializer<OrderTestRequest> {
  @override
  final Iterable<Type> types = const [OrderTestRequest, _$OrderTestRequest];

  @override
  final String wireName = r'OrderTestRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    OrderTestRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'test_id';
    yield serializers.serialize(
      object.testId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    OrderTestRequest object, {
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
    required OrderTestRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'test_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.testId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  OrderTestRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = OrderTestRequestBuilder();
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
