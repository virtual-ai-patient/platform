//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'acceptable_answer_response.g.dart';

/// AcceptableAnswerResponse
///
/// Properties:
/// * [field]
/// * [answer]
@BuiltValue()
abstract class AcceptableAnswerResponse
    implements
        Built<AcceptableAnswerResponse, AcceptableAnswerResponseBuilder> {
  @BuiltValueField(wireName: r'field')
  String get field;

  @BuiltValueField(wireName: r'answer')
  String get answer;

  AcceptableAnswerResponse._();

  factory AcceptableAnswerResponse(
          [void updates(AcceptableAnswerResponseBuilder b)]) =
      _$AcceptableAnswerResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AcceptableAnswerResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AcceptableAnswerResponse> get serializer =>
      _$AcceptableAnswerResponseSerializer();
}

class _$AcceptableAnswerResponseSerializer
    implements PrimitiveSerializer<AcceptableAnswerResponse> {
  @override
  final Iterable<Type> types = const [
    AcceptableAnswerResponse,
    _$AcceptableAnswerResponse
  ];

  @override
  final String wireName = r'AcceptableAnswerResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AcceptableAnswerResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'field';
    yield serializers.serialize(
      object.field,
      specifiedType: const FullType(String),
    );
    yield r'answer';
    yield serializers.serialize(
      object.answer,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    AcceptableAnswerResponse object, {
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
    required AcceptableAnswerResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'field':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.field = valueDes;
          break;
        case r'answer':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.answer = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  AcceptableAnswerResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AcceptableAnswerResponseBuilder();
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
