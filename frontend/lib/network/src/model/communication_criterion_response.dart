//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'communication_criterion_response.g.dart';

/// CommunicationCriterionResponse
///
/// Properties:
/// * [criterion]
/// * [score]
/// * [rationale]
/// * [quote]
@BuiltValue()
abstract class CommunicationCriterionResponse
    implements
        Built<
          CommunicationCriterionResponse,
          CommunicationCriterionResponseBuilder
        > {
  @BuiltValueField(wireName: r'criterion')
  String get criterion;

  @BuiltValueField(wireName: r'score')
  int get score;

  @BuiltValueField(wireName: r'rationale')
  String get rationale;

  @BuiltValueField(wireName: r'quote')
  String get quote;

  CommunicationCriterionResponse._();

  factory CommunicationCriterionResponse([
    void updates(CommunicationCriterionResponseBuilder b),
  ]) = _$CommunicationCriterionResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CommunicationCriterionResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CommunicationCriterionResponse> get serializer =>
      _$CommunicationCriterionResponseSerializer();
}

class _$CommunicationCriterionResponseSerializer
    implements PrimitiveSerializer<CommunicationCriterionResponse> {
  @override
  final Iterable<Type> types = const [
    CommunicationCriterionResponse,
    _$CommunicationCriterionResponse,
  ];

  @override
  final String wireName = r'CommunicationCriterionResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CommunicationCriterionResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'criterion';
    yield serializers.serialize(
      object.criterion,
      specifiedType: const FullType(String),
    );
    yield r'score';
    yield serializers.serialize(
      object.score,
      specifiedType: const FullType(int),
    );
    yield r'rationale';
    yield serializers.serialize(
      object.rationale,
      specifiedType: const FullType(String),
    );
    yield r'quote';
    yield serializers.serialize(
      object.quote,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CommunicationCriterionResponse object, {
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
    required CommunicationCriterionResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'criterion':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.criterion = valueDes;
          break;
        case r'score':
          final valueDes =
              serializers.deserialize(value, specifiedType: const FullType(int))
                  as int;
          result.score = valueDes;
          break;
        case r'rationale':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.rationale = valueDes;
          break;
        case r'quote':
          final valueDes =
              serializers.deserialize(
                    value,
                    specifiedType: const FullType(String),
                  )
                  as String;
          result.quote = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CommunicationCriterionResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CommunicationCriterionResponseBuilder();
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
