//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'medication.g.dart';

/// Medication
///
/// Properties:
/// * [name]
/// * [dose]
/// * [route]
@BuiltValue()
abstract class Medication implements Built<Medication, MedicationBuilder> {
  @BuiltValueField(wireName: r'name')
  String get name;

  @BuiltValueField(wireName: r'dose')
  String get dose;

  @BuiltValueField(wireName: r'route')
  String get route;

  Medication._();

  factory Medication([void updates(MedicationBuilder b)]) = _$Medication;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(MedicationBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<Medication> get serializer => _$MedicationSerializer();
}

class _$MedicationSerializer implements PrimitiveSerializer<Medication> {
  @override
  final Iterable<Type> types = const [Medication, _$Medication];

  @override
  final String wireName = r'Medication';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    Medication object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'name';
    yield serializers.serialize(
      object.name,
      specifiedType: const FullType(String),
    );
    yield r'dose';
    yield serializers.serialize(
      object.dose,
      specifiedType: const FullType(String),
    );
    yield r'route';
    yield serializers.serialize(
      object.route,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    Medication object, {
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
    required MedicationBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.name = valueDes;
          break;
        case r'dose':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.dose = valueDes;
          break;
        case r'route':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.route = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  Medication deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = MedicationBuilder();
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
