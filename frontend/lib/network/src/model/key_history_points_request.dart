//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'key_history_points_request.g.dart';

/// KeyHistoryPointsRequest
///
/// Properties:
/// * [mustAsk] 
/// * [niceToAsk] 
/// * [redFlags] 
@BuiltValue()
abstract class KeyHistoryPointsRequest implements Built<KeyHistoryPointsRequest, KeyHistoryPointsRequestBuilder> {
  @BuiltValueField(wireName: r'must_ask')
  BuiltList<String> get mustAsk;

  @BuiltValueField(wireName: r'nice_to_ask')
  BuiltList<String> get niceToAsk;

  @BuiltValueField(wireName: r'red_flags')
  BuiltList<String> get redFlags;

  KeyHistoryPointsRequest._();

  factory KeyHistoryPointsRequest([void updates(KeyHistoryPointsRequestBuilder b)]) = _$KeyHistoryPointsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(KeyHistoryPointsRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<KeyHistoryPointsRequest> get serializer => _$KeyHistoryPointsRequestSerializer();
}

class _$KeyHistoryPointsRequestSerializer implements PrimitiveSerializer<KeyHistoryPointsRequest> {
  @override
  final Iterable<Type> types = const [KeyHistoryPointsRequest, _$KeyHistoryPointsRequest];

  @override
  final String wireName = r'KeyHistoryPointsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    KeyHistoryPointsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'must_ask';
    yield serializers.serialize(
      object.mustAsk,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'nice_to_ask';
    yield serializers.serialize(
      object.niceToAsk,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'red_flags';
    yield serializers.serialize(
      object.redFlags,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    KeyHistoryPointsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required KeyHistoryPointsRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'must_ask':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.mustAsk.replace(valueDes);
          break;
        case r'nice_to_ask':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.niceToAsk.replace(valueDes);
          break;
        case r'red_flags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.redFlags.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  KeyHistoryPointsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = KeyHistoryPointsRequestBuilder();
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

