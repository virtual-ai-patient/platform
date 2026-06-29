//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/chat_message.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_state_response.g.dart';

/// SessionStateResponse
///
/// Properties:
/// * [sessionId]
/// * [status]
/// * [createdAt]
/// * [lastActivityAt]
/// * [caseSnapshot]
/// * [chatHistory]
/// * [nextCursor]
/// * [orderedTests]
/// * [conclusions]
@BuiltValue()
abstract class SessionStateResponse
    implements Built<SessionStateResponse, SessionStateResponseBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'last_activity_at')
  DateTime get lastActivityAt;

  @BuiltValueField(wireName: r'case_snapshot')
  BuiltMap<String, JsonObject?> get caseSnapshot;

  @BuiltValueField(wireName: r'chat_history')
  BuiltList<ChatMessage> get chatHistory;

  @BuiltValueField(wireName: r'next_cursor')
  int? get nextCursor;

  @BuiltValueField(wireName: r'ordered_tests')
  BuiltList<String> get orderedTests;

  @BuiltValueField(wireName: r'conclusions')
  BuiltMap<String, JsonObject?>? get conclusions;

  SessionStateResponse._();

  factory SessionStateResponse([void updates(SessionStateResponseBuilder b)]) =
      _$SessionStateResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionStateResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionStateResponse> get serializer =>
      _$SessionStateResponseSerializer();
}

class _$SessionStateResponseSerializer
    implements PrimitiveSerializer<SessionStateResponse> {
  @override
  final Iterable<Type> types = const [
    SessionStateResponse,
    _$SessionStateResponse,
  ];

  @override
  final String wireName = r'SessionStateResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionStateResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session_id';
    yield serializers.serialize(
      object.sessionId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'last_activity_at';
    yield serializers.serialize(
      object.lastActivityAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'case_snapshot';
    yield serializers.serialize(
      object.caseSnapshot,
      specifiedType: const FullType(BuiltMap, [
        FullType(String),
        FullType.nullable(JsonObject),
      ]),
    );
    yield r'chat_history';
    yield serializers.serialize(
      object.chatHistory,
      specifiedType: const FullType(BuiltList, [FullType(ChatMessage)]),
    );
    yield r'next_cursor';
    yield object.nextCursor == null
        ? null
        : serializers.serialize(
            object.nextCursor,
            specifiedType: const FullType.nullable(int),
          );
    yield r'ordered_tests';
    yield serializers.serialize(
      object.orderedTests,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'conclusions';
    yield object.conclusions == null
        ? null
        : serializers.serialize(
            object.conclusions,
            specifiedType: const FullType.nullable(BuiltMap, [
              FullType(String),
              FullType.nullable(JsonObject),
            ]),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionStateResponse object, {
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
    required SessionStateResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session_id':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.sessionId = valueDes;
          break;
        case r'status':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.status = valueDes;
          break;
        case r'created_at':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.createdAt = valueDes;
          break;
        case r'last_activity_at':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(DateTime),
                  )
                  as DateTime;
          result.lastActivityAt = valueDes;
          break;
        case r'case_snapshot':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltMap, [
                      FullType(String),
                      FullType.nullable(JsonObject),
                    ]),
                  )
                  as BuiltMap<String, JsonObject?>;
          result.caseSnapshot.replace(valueDes);
          break;
        case r'chat_history':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(ChatMessage),
                    ]),
                  )
                  as BuiltList<ChatMessage>;
          result.chatHistory.replace(valueDes);
          break;
        case r'next_cursor':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(int),
                  )
                  as int?;
          if (valueDes == null) continue;
          result.nextCursor = valueDes;
          break;
        case r'ordered_tests':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(BuiltList, [
                      FullType(String),
                    ]),
                  )
                  as BuiltList<String>;
          result.orderedTests.replace(valueDes);
          break;
        case r'conclusions':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType.nullable(BuiltMap, [
                      FullType(String),
                      FullType.nullable(JsonObject),
                    ]),
                  )
                  as BuiltMap<String, JsonObject?>?;
          if (valueDes == null) continue;
          result.conclusions.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionStateResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionStateResponseBuilder();
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
