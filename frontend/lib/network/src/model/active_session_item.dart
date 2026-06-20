//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:frontend/network/src/model/progress_summary.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'active_session_item.g.dart';

/// ActiveSessionItem
///
/// Properties:
/// * [sessionId]
/// * [caseId]
/// * [caseTitle]
/// * [createdAt]
/// * [lastActivityAt]
/// * [progressSummary]
@BuiltValue()
abstract class ActiveSessionItem
    implements Built<ActiveSessionItem, ActiveSessionItemBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'case_id')
  String get caseId;

  @BuiltValueField(wireName: r'case_title')
  String get caseTitle;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'last_activity_at')
  DateTime get lastActivityAt;

  @BuiltValueField(wireName: r'progress_summary')
  ProgressSummary get progressSummary;

  ActiveSessionItem._();

  factory ActiveSessionItem([void updates(ActiveSessionItemBuilder b)]) =
      _$ActiveSessionItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActiveSessionItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActiveSessionItem> get serializer =>
      _$ActiveSessionItemSerializer();
}

class _$ActiveSessionItemSerializer
    implements PrimitiveSerializer<ActiveSessionItem> {
  @override
  final Iterable<Type> types = const [ActiveSessionItem, _$ActiveSessionItem];

  @override
  final String wireName = r'ActiveSessionItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActiveSessionItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session_id';
    yield serializers.serialize(
      object.sessionId,
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
    yield r'last_activity_at';
    yield serializers.serialize(
      object.lastActivityAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'progress_summary';
    yield serializers.serialize(
      object.progressSummary,
      specifiedType: const FullType(ProgressSummary),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActiveSessionItem object, {
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
    required ActiveSessionItemBuilder result,
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
        case r'last_activity_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.lastActivityAt = valueDes;
          break;
        case r'progress_summary':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ProgressSummary),
          ) as ProgressSummary;
          result.progressSummary.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActiveSessionItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActiveSessionItemBuilder();
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
