//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'evaluation_finding_response.g.dart';

/// EvaluationFindingResponse
///
/// Properties:
/// * [category]
/// * [type]
/// * [severity]
/// * [expected]
/// * [actual]
/// * [whyMatters]
/// * [howToCorrect]
/// * [deductionPoints]
@BuiltValue()
abstract class EvaluationFindingResponse
    implements
        Built<EvaluationFindingResponse, EvaluationFindingResponseBuilder> {
  @BuiltValueField(wireName: r'category')
  String get category;

  @BuiltValueField(wireName: r'type')
  String get type;

  @BuiltValueField(wireName: r'severity')
  String get severity;

  @BuiltValueField(wireName: r'expected')
  String get expected;

  @BuiltValueField(wireName: r'actual')
  String get actual;

  @BuiltValueField(wireName: r'why_matters')
  String get whyMatters;

  @BuiltValueField(wireName: r'how_to_correct')
  String get howToCorrect;

  @BuiltValueField(wireName: r'deduction_points')
  num get deductionPoints;

  EvaluationFindingResponse._();

  factory EvaluationFindingResponse(
          [void updates(EvaluationFindingResponseBuilder b)]) =
      _$EvaluationFindingResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(EvaluationFindingResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<EvaluationFindingResponse> get serializer =>
      _$EvaluationFindingResponseSerializer();
}

class _$EvaluationFindingResponseSerializer
    implements PrimitiveSerializer<EvaluationFindingResponse> {
  @override
  final Iterable<Type> types = const [
    EvaluationFindingResponse,
    _$EvaluationFindingResponse
  ];

  @override
  final String wireName = r'EvaluationFindingResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    EvaluationFindingResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'category';
    yield serializers.serialize(
      object.category,
      specifiedType: const FullType(String),
    );
    yield r'type';
    yield serializers.serialize(
      object.type,
      specifiedType: const FullType(String),
    );
    yield r'severity';
    yield serializers.serialize(
      object.severity,
      specifiedType: const FullType(String),
    );
    yield r'expected';
    yield serializers.serialize(
      object.expected,
      specifiedType: const FullType(String),
    );
    yield r'actual';
    yield serializers.serialize(
      object.actual,
      specifiedType: const FullType(String),
    );
    yield r'why_matters';
    yield serializers.serialize(
      object.whyMatters,
      specifiedType: const FullType(String),
    );
    yield r'how_to_correct';
    yield serializers.serialize(
      object.howToCorrect,
      specifiedType: const FullType(String),
    );
    yield r'deduction_points';
    yield serializers.serialize(
      object.deductionPoints,
      specifiedType: const FullType(num),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    EvaluationFindingResponse object, {
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
    required EvaluationFindingResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'category':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.category = valueDes;
          break;
        case r'type':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.type = valueDes;
          break;
        case r'severity':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.severity = valueDes;
          break;
        case r'expected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.expected = valueDes;
          break;
        case r'actual':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.actual = valueDes;
          break;
        case r'why_matters':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.whyMatters = valueDes;
          break;
        case r'how_to_correct':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.howToCorrect = valueDes;
          break;
        case r'deduction_points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(num),
          ) as num;
          result.deductionPoints = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  EvaluationFindingResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = EvaluationFindingResponseBuilder();
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
