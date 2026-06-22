//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/communication_criterion_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'communication_evaluation_response.g.dart';

/// CommunicationEvaluationResponse
///
/// Properties:
/// * [sessionId]
/// * [model]
/// * [promptVersion]
/// * [totalScore]
/// * [createdAt]
/// * [criteria]
@BuiltValue()
abstract class CommunicationEvaluationResponse
    implements
        Built<CommunicationEvaluationResponse,
            CommunicationEvaluationResponseBuilder> {
  @BuiltValueField(wireName: r'session_id')
  String get sessionId;

  @BuiltValueField(wireName: r'model')
  String get model;

  @BuiltValueField(wireName: r'prompt_version')
  String get promptVersion;

  @BuiltValueField(wireName: r'total_score')
  num get totalScore;

  @BuiltValueField(wireName: r'created_at')
  DateTime get createdAt;

  @BuiltValueField(wireName: r'criteria')
  BuiltList<CommunicationCriterionResponse> get criteria;

  CommunicationEvaluationResponse._();

  factory CommunicationEvaluationResponse(
          [void updates(CommunicationEvaluationResponseBuilder b)]) =
      _$CommunicationEvaluationResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CommunicationEvaluationResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CommunicationEvaluationResponse> get serializer =>
      _$CommunicationEvaluationResponseSerializer();
}

class _$CommunicationEvaluationResponseSerializer
    implements PrimitiveSerializer<CommunicationEvaluationResponse> {
  @override
  final Iterable<Type> types = const [
    CommunicationEvaluationResponse,
    _$CommunicationEvaluationResponse
  ];

  @override
  final String wireName = r'CommunicationEvaluationResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CommunicationEvaluationResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'session_id';
    yield serializers.serialize(
      object.sessionId,
      specifiedType: const FullType(String),
    );
    yield r'model';
    yield serializers.serialize(
      object.model,
      specifiedType: const FullType(String),
    );
    yield r'prompt_version';
    yield serializers.serialize(
      object.promptVersion,
      specifiedType: const FullType(String),
    );
    yield r'total_score';
    yield serializers.serialize(
      object.totalScore,
      specifiedType: const FullType(num),
    );
    yield r'created_at';
    yield serializers.serialize(
      object.createdAt,
      specifiedType: const FullType(DateTime),
    );
    yield r'criteria';
    yield serializers.serialize(
      object.criteria,
      specifiedType:
          const FullType(BuiltList, [FullType(CommunicationCriterionResponse)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CommunicationEvaluationResponse object, {
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
    required CommunicationEvaluationResponseBuilder result,
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
        case r'model':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.model = valueDes;
          break;
        case r'prompt_version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.promptVersion = valueDes;
          break;
        case r'total_score':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.totalScore = valueDes;
          break;
        case r'created_at':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(DateTime),
          ) as DateTime;
          result.createdAt = valueDes;
          break;
        case r'criteria':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(
                BuiltList, [FullType(CommunicationCriterionResponse)]),
          ) as BuiltList<CommunicationCriterionResponse>;
          result.criteria.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CommunicationEvaluationResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CommunicationEvaluationResponseBuilder();
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
