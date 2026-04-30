//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/session_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'session_list_response.g.dart';

/// SessionListResponse
///
/// Properties:
/// * [sessions]
/// * [total]
/// * [page]
/// * [pageSize]
@BuiltValue()
abstract class SessionListResponse
    implements Built<SessionListResponse, SessionListResponseBuilder> {
  @BuiltValueField(wireName: r'sessions')
  BuiltList<SessionSummary> get sessions;

  @BuiltValueField(wireName: r'total')
  int get total;

  @BuiltValueField(wireName: r'page')
  int get page;

  @BuiltValueField(wireName: r'page_size')
  int get pageSize;

  SessionListResponse._();

  factory SessionListResponse([void updates(SessionListResponseBuilder b)]) =
      _$SessionListResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(SessionListResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<SessionListResponse> get serializer =>
      _$SessionListResponseSerializer();
}

class _$SessionListResponseSerializer
    implements PrimitiveSerializer<SessionListResponse> {
  @override
  final Iterable<Type> types = const [
    SessionListResponse,
    _$SessionListResponse
  ];

  @override
  final String wireName = r'SessionListResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    SessionListResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'sessions';
    yield serializers.serialize(
      object.sessions,
      specifiedType: const FullType(BuiltList, [FullType(SessionSummary)]),
    );
    yield r'total';
    yield serializers.serialize(
      object.total,
      specifiedType: const FullType(int),
    );
    yield r'page';
    yield serializers.serialize(
      object.page,
      specifiedType: const FullType(int),
    );
    yield r'page_size';
    yield serializers.serialize(
      object.pageSize,
      specifiedType: const FullType(int),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    SessionListResponse object, {
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
    required SessionListResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'sessions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(SessionSummary)]),
          ) as BuiltList<SessionSummary>;
          result.sessions.replace(valueDes);
          break;
        case r'total':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.total = valueDes;
          break;
        case r'page':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.page = valueDes;
          break;
        case r'page_size':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.pageSize = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  SessionListResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = SessionListResponseBuilder();
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
