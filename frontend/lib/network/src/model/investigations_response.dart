//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/investigation_result_response.dart';
import 'package:frontend/network/src/model/expected_tests_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'investigations_response.g.dart';

/// InvestigationsResponse
///
/// Properties:
/// * [catalogHints] 
/// * [expected] 
/// * [results] 
@BuiltValue()
abstract class InvestigationsResponse implements Built<InvestigationsResponse, InvestigationsResponseBuilder> {
  @BuiltValueField(wireName: r'catalog_hints')
  BuiltList<String> get catalogHints;

  @BuiltValueField(wireName: r'expected')
  ExpectedTestsResponse get expected;

  @BuiltValueField(wireName: r'results')
  BuiltList<InvestigationResultResponse> get results;

  InvestigationsResponse._();

  factory InvestigationsResponse([void updates(InvestigationsResponseBuilder b)]) = _$InvestigationsResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvestigationsResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<InvestigationsResponse> get serializer => _$InvestigationsResponseSerializer();
}

class _$InvestigationsResponseSerializer implements PrimitiveSerializer<InvestigationsResponse> {
  @override
  final Iterable<Type> types = const [InvestigationsResponse, _$InvestigationsResponse];

  @override
  final String wireName = r'InvestigationsResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvestigationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'catalog_hints';
    yield serializers.serialize(
      object.catalogHints,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'expected';
    yield serializers.serialize(
      object.expected,
      specifiedType: const FullType(ExpectedTestsResponse),
    );
    yield r'results';
    yield serializers.serialize(
      object.results,
      specifiedType: const FullType(BuiltList, [FullType(InvestigationResultResponse)]),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    InvestigationsResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvestigationsResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'catalog_hints':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.catalogHints.replace(valueDes);
          break;
        case r'expected':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ExpectedTestsResponse),
          ) as ExpectedTestsResponse;
          result.expected.replace(valueDes);
          break;
        case r'results':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InvestigationResultResponse)]),
          ) as BuiltList<InvestigationResultResponse>;
          result.results.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  InvestigationsResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvestigationsResponseBuilder();
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

