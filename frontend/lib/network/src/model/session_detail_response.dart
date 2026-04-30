//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:frontend/network/src/model/action_log_entry.dart';
import 'package:built_collection/built_collection.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_detail_response.g.dart';

/// SessionDetailResponse
///
/// Properties:
/// * [sessionId] 
/// * [studentUsername] 
/// * [caseId] 
/// * [caseTitle] 
/// * [createdAt] 
/// * [actionLog] 
@BuiltValue()
abstract class SessionDetailResponse implements Built<SessionDetailResponse, SessionDetailResponseBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'student_username')
  String get studentUsername;

  @BuiltValueField(wireName: r'case_id')
  String get caseId;

  @BuiltValueField(wireName: r'case_title')
  String get caseTitle;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'action_log')
  BuiltList<ActionLogEntry> get actionLog;

  SessionDetailResponse._();

  factory SessionDetailResponse([void updates(SessionDetailResponseBuilder b)]) = _$SessionDetailResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionDetailResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionDetailResponse> get serializer => _$SessionDetailResponseSerializer();
}

class _$SessionDetailResponseSerializer implements PrimitiveSerializer<SessionDetailResponse> {
  @override
  final Iterable<Type> types = const [SessionDetailResponse, _$SessionDetailResponse];

  @override
  final String wireName = r'SessionDetailResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session_id';
    yield serializers.serialize(
      object.sessionId,
      specifiedType: const FullType(String),
    );
    yield r'student_username';
    yield serializers.serialize(
      object.studentUsername,
      specifiedType: const FullType(String),
    );
    yield r'case_id';
    yield serializers.serialize(
      object.caseId,
      specifiedType: const FullType(String),
    );
    yield r'case_title';
    yield serializers.serialize(
      object.caseTitle,
      specifiedType: const FullType(String),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'action_log';
    yield serializers.serialize(
      object.actionLog,
      specifiedType: const FullType(BuiltList, [FullType(ActionLogEntry)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionDetailResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required SessionDetailResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'session_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.sessionId = valueDes;
          break;
        case r'student_username':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.studentUsername = valueDes;
          break;
        case r'case_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.caseId = valueDes;
          break;
        case r'case_title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.caseTitle = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'action_log':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(ActionLogEntry)]),
          ) as BuiltList<ActionLogEntry>;
          result.actionLog.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionDetailResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionDetailResponseBuilder();
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

