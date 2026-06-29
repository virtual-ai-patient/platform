//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'chat_message.g.dart';

/// ChatMessage
///
/// Properties:
/// * [role]
/// * [content]
/// * [loggedAt]
@BuiltValue()
abstract class ChatMessage implements Built<ChatMessage, ChatMessageBuilder> {
  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'logged_at')
  DateTime get loggedAt;

  ChatMessage._();

  factory ChatMessage([void updates(ChatMessageBuilder b)]) = _$ChatMessage;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ChatMessageBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ChatMessage> get serializer => _$ChatMessageSerializer();
}

class _$ChatMessageSerializer implements PrimitiveSerializer<ChatMessage> {
  @override
  final Iterable<Type> types = const [ChatMessage, _$ChatMessage];

  @override
  final String wireName = r'ChatMessage';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ChatMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'role';
    yield serializers.serialize(
      object.role,
      specifiedType: const FullType(String),
    );
    yield r'content';
    yield serializers.serialize(
      object.content,
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
    ChatMessage object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(
      serializers,
      object,
      specifiedType: specifiedType,
    ).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required ChatMessageBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.role = valueDes;
          break;
        case r'content':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.content = valueDes;
          break;
        case r'logged_at':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
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
  ChatMessage deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ChatMessageBuilder();
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
