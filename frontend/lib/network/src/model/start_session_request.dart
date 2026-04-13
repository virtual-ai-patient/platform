//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'start_session_request.g.dart';

/// StartSessionRequest
///
/// Properties:
/// * [caseId]
@BuiltValue()
abstract class StartSessionRequest
    implements Built<StartSessionRequest, StartSessionRequestBuilder> {
  @BuiltValueField(wireName: r'case_id')
  String get caseId;

  StartSessionRequest._();

  factory StartSessionRequest([void updates(StartSessionRequestBuilder b)]) =
      _$StartSessionRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(StartSessionRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<StartSessionRequest> get serializer =>
      _$StartSessionRequestSerializer();
}

class _$StartSessionRequestSerializer
    implements PrimitiveSerializer<StartSessionRequest> {
  @override
  final Iterable<Type> types = const [
    StartSessionRequest,
    _$StartSessionRequest
  ];

  @override
  final String wireName = r'StartSessionRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    StartSessionRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'case_id';
    yield serializers.serialize(
      object.caseId,
      specifiedType: const FullType(String),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    StartSessionRequest object, {
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
    required StartSessionRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'case_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.caseId = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  StartSessionRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = StartSessionRequestBuilder();
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
