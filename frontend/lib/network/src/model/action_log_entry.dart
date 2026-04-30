//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'action_log_entry.g.dart';

/// ActionLogEntry
///
/// Properties:
/// * [role]
/// * [content]
/// * [createdAt]
@BuiltValue()
abstract class ActionLogEntry
    implements Built<ActionLogEntry, ActionLogEntryBuilder> {
  @BuiltValueField(wireName: r'role')
  String get role;

  @BuiltValueField(wireName: r'content')
  String get content;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  ActionLogEntry._();

  factory ActionLogEntry([void updates(ActionLogEntryBuilder b)]) =
      _$ActionLogEntry;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ActionLogEntryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ActionLogEntry> get serializer =>
      _$ActionLogEntrySerializer();
}

class _$ActionLogEntrySerializer
    implements PrimitiveSerializer<ActionLogEntry> {
  @override
  final Iterable<Type> types = const [ActionLogEntry, _$ActionLogEntry];

  @override
  final String wireName = r'ActionLogEntry';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ActionLogEntry object, {
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
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ActionLogEntry object, {
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
    required ActionLogEntryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'role':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.role = valueDes;
          break;
        case r'content':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.content = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ActionLogEntry deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ActionLogEntryBuilder();
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
