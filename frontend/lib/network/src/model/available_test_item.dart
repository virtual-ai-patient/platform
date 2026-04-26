//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'available_test_item.g.dart';

/// AvailableTestItem
///
/// Properties:
/// * [testName]
/// * [category]
@BuiltValue()
abstract class AvailableTestItem
    implements Built<AvailableTestItem, AvailableTestItemBuilder> {
  @BuiltValueField(wireName: r'test_name')
  String get testName;

  @BuiltValueField(wireName: r'category')
  String get category;

  AvailableTestItem._();

  factory AvailableTestItem([void updates(AvailableTestItemBuilder b)]) =
      _$AvailableTestItem;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailableTestItemBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailableTestItem> get serializer =>
      _$AvailableTestItemSerializer();
}

class _$AvailableTestItemSerializer
    implements PrimitiveSerializer<AvailableTestItem> {
  @override
  final Iterable<Type> types = const [AvailableTestItem, _$AvailableTestItem];

  @override
  final String wireName = r'AvailableTestItem';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailableTestItem object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'test_name';
    yield serializers.serialize(
      object.testName,
      specifiedType: const FullType(String),
    );
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailableTestItem object, {
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
    required AvailableTestItemBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'test_name':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.testName = valueDes;
          break;
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailableTestItem deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailableTestItemBuilder();
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
