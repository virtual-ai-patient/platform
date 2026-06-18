//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/available_test_item.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'available_tests_response.g.dart';

/// AvailableTestsResponse
///
/// Properties:
/// * [tests]
@BuiltValue()
abstract class AvailableTestsResponse
    implements Built<AvailableTestsResponse, AvailableTestsResponseBuilder> {
  @BuiltValueField(wireName: r'tests')
  BuiltList<AvailableTestItem> get tests;

  AvailableTestsResponse._();

  factory AvailableTestsResponse(
          [void updates(AvailableTestsResponseBuilder b)]) =
      _$AvailableTestsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AvailableTestsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AvailableTestsResponse> get serializer =>
      _$AvailableTestsResponseSerializer();
}

class _$AvailableTestsResponseSerializer
    implements PrimitiveSerializer<AvailableTestsResponse> {
  @override
  final Iterable<Type> types = const [
    AvailableTestsResponse,
    _$AvailableTestsResponse
  ];

  @override
  final String wireName = r'AvailableTestsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AvailableTestsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'tests';
    yield serializers.serialize(
      object.tests,
      specifiedType: const FullType(BuiltList, [FullType(AvailableTestItem)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AvailableTestsResponse object, {
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
    required AvailableTestsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'tests':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType(BuiltList, [FullType(AvailableTestItem)]),
          ) as BuiltList<AvailableTestItem>;
          result.tests.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AvailableTestsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AvailableTestsResponseBuilder();
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
