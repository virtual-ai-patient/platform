//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:frontend/network/src/model/investigations_request.dart';
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/management_request.dart';
import 'package:frontend/network/src/model/key_history_points_request.dart';
import 'package:frontend/network/src/model/scoring_request.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'create_case_request.g.dart';

/// CreateCaseRequest
///
/// Properties:
/// * [caseId]
/// * [title]
/// * [language]
/// * [difficulty]
/// * [specialty]
/// * [tags]
/// * [age]
/// * [sex]
/// * [persona]
/// * [tonePresets]
/// * [chiefComplaint]
/// * [historyOfPresentIllness]
/// * [keyHistoryPoints]
/// * [finalDiagnosis]
/// * [differential]
/// * [severityOrStage]
/// * [investigations]
/// * [management]
/// * [scoring]
/// * [status]
@BuiltValue()
abstract class CreateCaseRequest
    implements Built<CreateCaseRequest, CreateCaseRequestBuilder> {
  @BuiltValueField(wireName: r'case_id')
  String get caseId;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'language')
  CreateCaseRequestLanguageEnum get language;
  // enum languageEnum {  en,  };

  @BuiltValueField(wireName: r'difficulty')
  CreateCaseRequestDifficultyEnum get difficulty;
  // enum difficultyEnum {  easy,  medium,  hard,  };

  @BuiltValueField(wireName: r'specialty')
  String get specialty;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'age')
  int get age;

  @BuiltValueField(wireName: r'sex')
  CreateCaseRequestSexEnum get sex;
  // enum sexEnum {  female,  male,  other,  };

  @BuiltValueField(wireName: r'persona')
  String get persona;

  @BuiltValueField(wireName: r'tone_presets')
  BuiltList<String>? get tonePresets;

  @BuiltValueField(wireName: r'chief_complaint')
  String get chiefComplaint;

  @BuiltValueField(wireName: r'history_of_present_illness')
  String get historyOfPresentIllness;

  @BuiltValueField(wireName: r'key_history_points')
  KeyHistoryPointsRequest get keyHistoryPoints;

  @BuiltValueField(wireName: r'final_diagnosis')
  String get finalDiagnosis;

  @BuiltValueField(wireName: r'differential')
  BuiltList<String>? get differential;

  @BuiltValueField(wireName: r'severity_or_stage')
  String? get severityOrStage;

  @BuiltValueField(wireName: r'investigations')
  InvestigationsRequest get investigations;

  @BuiltValueField(wireName: r'management')
  ManagementRequest get management;

  @BuiltValueField(wireName: r'scoring')
  ScoringRequest get scoring;

  @BuiltValueField(wireName: r'status')
  CreateCaseRequestStatusEnum? get status;
  // enum statusEnum {  draft,  review,  published,  };

  CreateCaseRequest._();

  factory CreateCaseRequest([void updates(CreateCaseRequestBuilder b)]) =
      _$CreateCaseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CreateCaseRequestBuilder b) => b
    ..tags = ListBuilder()
    ..tonePresets = ListBuilder()
    ..differential = ListBuilder()
    ..status = CreateCaseRequestStatusEnum.valueOf('draft');

  @BuiltValueSerializer(custom: true)
  static Serializer<CreateCaseRequest> get serializer =>
      _$CreateCaseRequestSerializer();
}

class _$CreateCaseRequestSerializer
    implements PrimitiveSerializer<CreateCaseRequest> {
  @override
  final Iterable<Type> types = const [CreateCaseRequest, _$CreateCaseRequest];

  @override
  final String wireName = r'CreateCaseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CreateCaseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'case_id';
    yield serializers.serialize(
      object.caseId,
      specifiedType: const FullType(String),
    );
    yield r'title';
    yield serializers.serialize(
      object.title,
      specifiedType: const FullType(String),
    );
    yield r'language';
    yield serializers.serialize(
      object.language,
      specifiedType: const FullType(CreateCaseRequestLanguageEnum),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(CreateCaseRequestDifficultyEnum),
    );
    yield r'specialty';
    yield serializers.serialize(
      object.specialty,
      specifiedType: const FullType(String),
    );
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'age';
    yield serializers.serialize(
      object.age,
      specifiedType: const FullType(int),
    );
    yield r'sex';
    yield serializers.serialize(
      object.sex,
      specifiedType: const FullType(CreateCaseRequestSexEnum),
    );
    yield r'persona';
    yield serializers.serialize(
      object.persona,
      specifiedType: const FullType(String),
    );
    if (object.tonePresets != null) {
      yield r'tone_presets';
      yield serializers.serialize(
        object.tonePresets,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    yield r'chief_complaint';
    yield serializers.serialize(
      object.chiefComplaint,
      specifiedType: const FullType(String),
    );
    yield r'history_of_present_illness';
    yield serializers.serialize(
      object.historyOfPresentIllness,
      specifiedType: const FullType(String),
    );
    yield r'key_history_points';
    yield serializers.serialize(
      object.keyHistoryPoints,
      specifiedType: const FullType(KeyHistoryPointsRequest),
    );
    yield r'final_diagnosis';
    yield serializers.serialize(
      object.finalDiagnosis,
      specifiedType: const FullType(String),
    );
    if (object.differential != null) {
      yield r'differential';
      yield serializers.serialize(
        object.differential,
        specifiedType: const FullType(BuiltList, [FullType(String)]),
      );
    }
    if (object.severityOrStage != null) {
      yield r'severity_or_stage';
      yield serializers.serialize(
        object.severityOrStage,
        specifiedType: const FullType.nullable(String),
      );
    }
    yield r'investigations';
    yield serializers.serialize(
      object.investigations,
      specifiedType: const FullType(InvestigationsRequest),
    );
    yield r'management';
    yield serializers.serialize(
      object.management,
      specifiedType: const FullType(ManagementRequest),
    );
    yield r'scoring';
    yield serializers.serialize(
      object.scoring,
      specifiedType: const FullType(ScoringRequest),
    );
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType(CreateCaseRequestStatusEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    CreateCaseRequest object, {
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
    required CreateCaseRequestBuilder result,
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
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.title = valueDes;
          break;
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateCaseRequestLanguageEnum),
          ) as CreateCaseRequestLanguageEnum;
          result.language = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateCaseRequestDifficultyEnum),
          ) as CreateCaseRequestDifficultyEnum;
          result.difficulty = valueDes;
          break;
        case r'specialty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.specialty = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tags.replace(valueDes);
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.age = valueDes;
          break;
        case r'sex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateCaseRequestSexEnum),
          ) as CreateCaseRequestSexEnum;
          result.sex = valueDes;
          break;
        case r'persona':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.persona = valueDes;
          break;
        case r'tone_presets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.tonePresets.replace(valueDes);
          break;
        case r'chief_complaint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.chiefComplaint = valueDes;
          break;
        case r'history_of_present_illness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.historyOfPresentIllness = valueDes;
          break;
        case r'key_history_points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(KeyHistoryPointsRequest),
          ) as KeyHistoryPointsRequest;
          result.keyHistoryPoints.replace(valueDes);
          break;
        case r'final_diagnosis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.finalDiagnosis = valueDes;
          break;
        case r'differential':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(BuiltList, [FullType(String)]),
          ) as BuiltList<String>;
          result.differential.replace(valueDes);
          break;
        case r'severity_or_stage':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.severityOrStage = valueDes;
          break;
        case r'investigations':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(InvestigationsRequest),
          ) as InvestigationsRequest;
          result.investigations.replace(valueDes);
          break;
        case r'management':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ManagementRequest),
          ) as ManagementRequest;
          result.management.replace(valueDes);
          break;
        case r'scoring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScoringRequest),
          ) as ScoringRequest;
          result.scoring.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(CreateCaseRequestStatusEnum),
          ) as CreateCaseRequestStatusEnum;
          result.status = valueDes;
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CreateCaseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CreateCaseRequestBuilder();
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

class CreateCaseRequestLanguageEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'en')
  static const CreateCaseRequestLanguageEnum en =
      _$createCaseRequestLanguageEnum_en;

  static Serializer<CreateCaseRequestLanguageEnum> get serializer =>
      _$createCaseRequestLanguageEnumSerializer;

  const CreateCaseRequestLanguageEnum._(String name) : super(name);

  static BuiltSet<CreateCaseRequestLanguageEnum> get values =>
      _$createCaseRequestLanguageEnumValues;
  static CreateCaseRequestLanguageEnum valueOf(String name) =>
      _$createCaseRequestLanguageEnumValueOf(name);
}

class CreateCaseRequestDifficultyEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'easy')
  static const CreateCaseRequestDifficultyEnum easy =
      _$createCaseRequestDifficultyEnum_easy;
  @BuiltValueEnumConst(wireName: r'medium')
  static const CreateCaseRequestDifficultyEnum medium =
      _$createCaseRequestDifficultyEnum_medium;
  @BuiltValueEnumConst(wireName: r'hard')
  static const CreateCaseRequestDifficultyEnum hard =
      _$createCaseRequestDifficultyEnum_hard;

  static Serializer<CreateCaseRequestDifficultyEnum> get serializer =>
      _$createCaseRequestDifficultyEnumSerializer;

  const CreateCaseRequestDifficultyEnum._(String name) : super(name);

  static BuiltSet<CreateCaseRequestDifficultyEnum> get values =>
      _$createCaseRequestDifficultyEnumValues;
  static CreateCaseRequestDifficultyEnum valueOf(String name) =>
      _$createCaseRequestDifficultyEnumValueOf(name);
}

class CreateCaseRequestSexEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'female')
  static const CreateCaseRequestSexEnum female =
      _$createCaseRequestSexEnum_female;
  @BuiltValueEnumConst(wireName: r'male')
  static const CreateCaseRequestSexEnum male = _$createCaseRequestSexEnum_male;
  @BuiltValueEnumConst(wireName: r'other')
  static const CreateCaseRequestSexEnum other =
      _$createCaseRequestSexEnum_other;

  static Serializer<CreateCaseRequestSexEnum> get serializer =>
      _$createCaseRequestSexEnumSerializer;

  const CreateCaseRequestSexEnum._(String name) : super(name);

  static BuiltSet<CreateCaseRequestSexEnum> get values =>
      _$createCaseRequestSexEnumValues;
  static CreateCaseRequestSexEnum valueOf(String name) =>
      _$createCaseRequestSexEnumValueOf(name);
}

class CreateCaseRequestStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'draft')
  static const CreateCaseRequestStatusEnum draft =
      _$createCaseRequestStatusEnum_draft;
  @BuiltValueEnumConst(wireName: r'review')
  static const CreateCaseRequestStatusEnum review =
      _$createCaseRequestStatusEnum_review;
  @BuiltValueEnumConst(wireName: r'published')
  static const CreateCaseRequestStatusEnum published =
      _$createCaseRequestStatusEnum_published;

  static Serializer<CreateCaseRequestStatusEnum> get serializer =>
      _$createCaseRequestStatusEnumSerializer;

  const CreateCaseRequestStatusEnum._(String name) : super(name);

  static BuiltSet<CreateCaseRequestStatusEnum> get values =>
      _$createCaseRequestStatusEnumValues;
  static CreateCaseRequestStatusEnum valueOf(String name) =>
      _$createCaseRequestStatusEnumValueOf(name);
}
