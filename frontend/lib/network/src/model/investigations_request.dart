//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/expected_tests_request.dart';
import 'package:frontend/network/src/model/investigation_result_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'investigations_request.g.dart';

/// InvestigationsRequest
///
/// Properties:
/// * [catalogHints] 
/// * [expected] 
/// * [results] 
@BuiltValue()
abstract class InvestigationsRequest implements Built<InvestigationsRequest, InvestigationsRequestBuilder> {
  @BuiltValueField(wireName: r'catalog_hints')
  BuiltList<String>? get catalogHints;

  @BuiltValueField(wireName: r'expected')
  ExpectedTestsRequest get expected;

  @BuiltValueField(wireName: r'results')
  BuiltList<InvestigationResultRequest>? get results;

  InvestigationsRequest._();

  factory InvestigationsRequest([void updates(InvestigationsRequestBuilder b)]) = _$InvestigationsRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(InvestigationsRequestBuilder b) => b
      ..catalogHints = ListBuilder()
      ..results = ListBuilder();

  @BuiltValueSerializer(custom: true)
  static Serializer<InvestigationsRequest> get serializer => _$InvestigationsRequestSerializer();
}

class _$InvestigationsRequestSerializer implements PrimitiveSerializer<InvestigationsRequest> {
  @override
  final Iterable<Type> types = const [InvestigationsRequest, _$InvestigationsRequest];

  @override
  final String wireName = r'InvestigationsRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    InvestigationsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.catalogHints != null) {
      yield r'catalog_hints';
      yield serializers.serialize(
        object.catalogHints,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'expected';
    yield serializers.serialize(
      object.expected,
      specifiedType: const FullType(ExpectedTestsRequest),
    );
    if (object.results != null) {
      yield r'results';
      yield serializers.serialize(
        object.results,
        specifiedType: const FullType(BuiltList, [FullType(InvestigationResultRequest)]),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    InvestigationsRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required InvestigationsRequestBuilder result,
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
            specifiedType: const FullType(ExpectedTestsRequest),
          ) as ExpectedTestsRequest;
          result.expected.replace(valueDes);
          break;
        case r'results':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(InvestigationResultRequest)]),
          ) as BuiltList<InvestigationResultRequest>;
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
  InvestigationsRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = InvestigationsRequestBuilder();
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

