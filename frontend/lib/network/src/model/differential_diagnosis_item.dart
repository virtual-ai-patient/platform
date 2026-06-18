//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'differential_diagnosis_item.g.dart';

/// DifferentialDiagnosisItem
///
/// Properties:
/// * [rank]
/// * [condition]
@BuiltValue()
abstract class DifferentialDiagnosisItem
    implements
        Built<DifferentialDiagnosisItem, DifferentialDiagnosisItemBuilder> {
  @BuiltValueField(wireName: r'rank')
  int get rank;

  @BuiltValueField(wireName: r'condition')
  String get condition;

  DifferentialDiagnosisItem._();

  factory DifferentialDiagnosisItem(
          [void updates(DifferentialDiagnosisItemBuilder b)]) =
      _$DifferentialDiagnosisItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(DifferentialDiagnosisItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<DifferentialDiagnosisItem> get serializer =>
      _$DifferentialDiagnosisItemSerializer();
}

class _$DifferentialDiagnosisItemSerializer
    implements PrimitiveSerializer<DifferentialDiagnosisItem> {
  @override
  final Iterable<Type> types = const [
    DifferentialDiagnosisItem,
    _$DifferentialDiagnosisItem
  ];

  @override
  final String wireName = r'DifferentialDiagnosisItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    DifferentialDiagnosisItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'rank';
    yield serializers.serialize(
      object.rank,
      specifiedType: const FullType(int),
    );
    yield r'condition';
    yield serializers.serialize(
      object.condition,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    DifferentialDiagnosisItem object, {
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
    required DifferentialDiagnosisItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'rank':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.rank = valueDes;
          break;
        case r'condition':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.condition = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  DifferentialDiagnosisItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DifferentialDiagnosisItemBuilder();
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
