//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:built_value/json_object.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'conclusions_response.g.dart';

/// ConclusionsResponse
///
/// Properties:
/// * [sessionId]
/// * [status]
/// * [conclusions]
@BuiltValue()
abstract class ConclusionsResponse
    implements Built<ConclusionsResponse, ConclusionsResponseBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'conclusions')
  BuiltMap<String, JsonObject?>? get conclusions;

  ConclusionsResponse._();

  factory ConclusionsResponse([void updates(ConclusionsResponseBuilder b)]) =
      _$ConclusionsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(ConclusionsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<ConclusionsResponse> get serializer =>
      _$ConclusionsResponseSerializer();
}

class _$ConclusionsResponseSerializer
    implements PrimitiveSerializer<ConclusionsResponse> {
  @override
  final Iterable<Type> types = const [
    ConclusionsResponse,
    _$ConclusionsResponse
  ];

  @override
  final String wireName = r'ConclusionsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    ConclusionsResponse object, {
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
    yield r'conclusions';
    yield object.conclusions == null
        ? null
        : serializers.serialize(
            object.conclusions,
            specifiedType: const FullType.nullable(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          );
  }

  @override
  Object serialize(
    Serializers serializers,
    ConclusionsResponse object, {
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
    required ConclusionsResponseBuilder result,
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
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'conclusions':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(
                BuiltMap, [FullType(String), FullType.nullable(JsonObject)]),
          ) as BuiltMap<String, JsonObject?>?;
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
  ConclusionsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ConclusionsResponseBuilder();
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
