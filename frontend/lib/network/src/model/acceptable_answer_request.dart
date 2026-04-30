//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'acceptable_answer_request.g.dart';

/// AcceptableAnswerRequest
///
/// Properties:
/// * [field] 
/// * [answer] 
@BuiltValue()
abstract class AcceptableAnswerRequest implements Built<AcceptableAnswerRequest, AcceptableAnswerRequestBuilder> {
  @BuiltValueField(wireName: r'field')
  String get field;

  @BuiltValueField(wireName: r'answer')
  String get answer;

  AcceptableAnswerRequest._();

  factory AcceptableAnswerRequest([void updates(AcceptableAnswerRequestBuilder b)]) = _$AcceptableAnswerRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(AcceptableAnswerRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<AcceptableAnswerRequest> get serializer => _$AcceptableAnswerRequestSerializer();
}

class _$AcceptableAnswerRequestSerializer implements PrimitiveSerializer<AcceptableAnswerRequest> {
  @override
  final Iterable<Type> types = const [AcceptableAnswerRequest, _$AcceptableAnswerRequest];

  @override
  final String wireName = r'AcceptableAnswerRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    AcceptableAnswerRequest object, {
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
    AcceptableAnswerRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required AcceptableAnswerRequestBuilder result,
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
  AcceptableAnswerRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = AcceptableAnswerRequestBuilder();
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

