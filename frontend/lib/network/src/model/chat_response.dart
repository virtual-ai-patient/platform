//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_response.g.dart';

/// ChatResponse
///
/// Properties:
/// * [response]
/// * [loggedAt]
@BuiltValue()
abstract class ChatResponse
    implements Built<ChatResponse, ChatResponseBuilder> {
  @BuiltValueField(wireName: r'response')
  String get response;

  @BuiltValueField(wireName: r'logged_at')
  DateTime get loggedAt;

  ChatResponse._();

  factory ChatResponse([void updates(ChatResponseBuilder b)]) = _$ChatResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatResponse> get serializer => _$ChatResponseSerializer();
}

class _$ChatResponseSerializer implements PrimitiveSerializer<ChatResponse> {
  @override
  final Iterable<Type> types = const [ChatResponse, _$ChatResponse];

  @override
  final String wireName = r'ChatResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'response';
    yield serializers.serialize(
      object.response,
      specifiedType: const FullType(String),
    );
    yield r'logged_at';
    yield serializers.serialize(
      object.loggedAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ChatResponse object, {
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
    required ChatResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'response':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.response = valueDes;
          break;
        case r'logged_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.loggedAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ChatResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatResponseBuilder();
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
