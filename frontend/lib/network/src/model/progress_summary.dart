//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'progress_summary.g.dart';

/// ProgressSummary
///
/// Properties:
/// * [turnCount]
/// * [hasConclusions]
@BuiltValue()
abstract class ProgressSummary
    implements Built<ProgressSummary, ProgressSummaryBuilder> {
  @BuiltValueField(wireName: r'turn_count')
  int get turnCount;

  @BuiltValueField(wireName: r'has_conclusions')
  bool get hasConclusions;

  ProgressSummary._();

  factory ProgressSummary([void updates(ProgressSummaryBuilder b)]) =
      _$ProgressSummary;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ProgressSummaryBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ProgressSummary> get serializer =>
      _$ProgressSummarySerializer();
}

class _$ProgressSummarySerializer
    implements PrimitiveSerializer<ProgressSummary> {
  @override
  final Iterable<Type> types = const [ProgressSummary, _$ProgressSummary];

  @override
  final String wireName = r'ProgressSummary';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ProgressSummary object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'turn_count';
    yield serializers.serialize(
      object.turnCount,
      specifiedType: const FullType(int),
    );
    yield r'has_conclusions';
    yield serializers.serialize(
      object.hasConclusions,
      specifiedType: const FullType(bool),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    ProgressSummary object, {
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
    required ProgressSummaryBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'turn_count':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.turnCount = valueDes;
          break;
        case r'has_conclusions':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(bool),
                  )
                  as bool;
          result.hasConclusions = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  ProgressSummary deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ProgressSummaryBuilder();
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
