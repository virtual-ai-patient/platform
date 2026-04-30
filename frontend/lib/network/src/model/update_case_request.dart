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

part 'update_case_request.g.dart';

/// UpdateCaseRequest
///
/// Properties:
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
abstract class UpdateCaseRequest
    implements Built<UpdateCaseRequest, UpdateCaseRequestBuilder> {
  @BuiltValueField(wireName: r'title')
  String? get title;

  @BuiltValueField(wireName: r'language')
  UpdateCaseRequestLanguageEnum? get language;
  // enum languageEnum {  en,  };

  @BuiltValueField(wireName: r'difficulty')
  UpdateCaseRequestDifficultyEnum? get difficulty;
  // enum difficultyEnum {  easy,  medium,  hard,  };

  @BuiltValueField(wireName: r'specialty')
  String? get specialty;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String>? get tags;

  @BuiltValueField(wireName: r'age')
  int? get age;

  @BuiltValueField(wireName: r'sex')
  UpdateCaseRequestSexEnum? get sex;
  // enum sexEnum {  female,  male,  other,  };

  @BuiltValueField(wireName: r'persona')
  String? get persona;

  @BuiltValueField(wireName: r'tone_presets')
  BuiltList<String>? get tonePresets;

  @BuiltValueField(wireName: r'chief_complaint')
  String? get chiefComplaint;

  @BuiltValueField(wireName: r'history_of_present_illness')
  String? get historyOfPresentIllness;

  @BuiltValueField(wireName: r'key_history_points')
  KeyHistoryPointsRequest? get keyHistoryPoints;

  @BuiltValueField(wireName: r'final_diagnosis')
  String? get finalDiagnosis;

  @BuiltValueField(wireName: r'differential')
  BuiltList<String>? get differential;

  @BuiltValueField(wireName: r'severity_or_stage')
  String? get severityOrStage;

  @BuiltValueField(wireName: r'investigations')
  InvestigationsRequest? get investigations;

  @BuiltValueField(wireName: r'management')
  ManagementRequest? get management;

  @BuiltValueField(wireName: r'scoring')
  ScoringRequest? get scoring;

  @BuiltValueField(wireName: r'status')
  UpdateCaseRequestStatusEnum? get status;
  // enum statusEnum {  draft,  review,  published,  };

  UpdateCaseRequest._();

  factory UpdateCaseRequest([void updates(UpdateCaseRequestBuilder b)]) =
      _$UpdateCaseRequest;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(UpdateCaseRequestBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<UpdateCaseRequest> get serializer =>
      _$UpdateCaseRequestSerializer();
}

class _$UpdateCaseRequestSerializer
    implements PrimitiveSerializer<UpdateCaseRequest> {
  @override
  final Iterable<Type> types = const [UpdateCaseRequest, _$UpdateCaseRequest];

  @override
  final String wireName = r'UpdateCaseRequest';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    UpdateCaseRequest object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    if (object.title != null) {
      yield r'title';
      yield serializers.serialize(
        object.title,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.language != null) {
      yield r'language';
      yield serializers.serialize(
        object.language,
        specifiedType: const FullType.nullable(UpdateCaseRequestLanguageEnum),
      );
    }
    if (object.difficulty != null) {
      yield r'difficulty';
      yield serializers.serialize(
        object.difficulty,
        specifiedType: const FullType.nullable(UpdateCaseRequestDifficultyEnum),
      );
    }
    if (object.specialty != null) {
      yield r'specialty';
      yield serializers.serialize(
        object.specialty,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.tags != null) {
      yield r'tags';
      yield serializers.serialize(
        object.tags,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.age != null) {
      yield r'age';
      yield serializers.serialize(
        object.age,
        specifiedType: const FullType.nullable(int),
      );
    }
    if (object.sex != null) {
      yield r'sex';
      yield serializers.serialize(
        object.sex,
        specifiedType: const FullType.nullable(UpdateCaseRequestSexEnum),
      );
    }
    if (object.persona != null) {
      yield r'persona';
      yield serializers.serialize(
        object.persona,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.tonePresets != null) {
      yield r'tone_presets';
      yield serializers.serialize(
        object.tonePresets,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.chiefComplaint != null) {
      yield r'chief_complaint';
      yield serializers.serialize(
        object.chiefComplaint,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.historyOfPresentIllness != null) {
      yield r'history_of_present_illness';
      yield serializers.serialize(
        object.historyOfPresentIllness,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.keyHistoryPoints != null) {
      yield r'key_history_points';
      yield serializers.serialize(
        object.keyHistoryPoints,
        specifiedType: const FullType.nullable(KeyHistoryPointsRequest),
      );
    }
    if (object.finalDiagnosis != null) {
      yield r'final_diagnosis';
      yield serializers.serialize(
        object.finalDiagnosis,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.differential != null) {
      yield r'differential';
      yield serializers.serialize(
        object.differential,
        specifiedType: const FullType.nullable(BuiltList, [FullType(String)]),
      );
    }
    if (object.severityOrStage != null) {
      yield r'severity_or_stage';
      yield serializers.serialize(
        object.severityOrStage,
        specifiedType: const FullType.nullable(String),
      );
    }
    if (object.investigations != null) {
      yield r'investigations';
      yield serializers.serialize(
        object.investigations,
        specifiedType: const FullType.nullable(InvestigationsRequest),
      );
    }
    if (object.management != null) {
      yield r'management';
      yield serializers.serialize(
        object.management,
        specifiedType: const FullType.nullable(ManagementRequest),
      );
    }
    if (object.scoring != null) {
      yield r'scoring';
      yield serializers.serialize(
        object.scoring,
        specifiedType: const FullType.nullable(ScoringRequest),
      );
    }
    if (object.status != null) {
      yield r'status';
      yield serializers.serialize(
        object.status,
        specifiedType: const FullType.nullable(UpdateCaseRequestStatusEnum),
      );
    }
  }

  @override
  Object serialize(
    Serializers serializers,
    UpdateCaseRequest object, {
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
    required UpdateCaseRequestBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'title':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.title = valueDes;
          break;
        case r'language':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(UpdateCaseRequestLanguageEnum),
          ) as UpdateCaseRequestLanguageEnum?;
          if (valueDes == null) continue;
          result.language = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(UpdateCaseRequestDifficultyEnum),
          ) as UpdateCaseRequestDifficultyEnum?;
          if (valueDes == null) continue;
          result.difficulty = valueDes;
          break;
        case r'specialty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.specialty = valueDes;
          break;
        case r'tags':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.tags.replace(valueDes);
          break;
        case r'age':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(int),
          ) as int?;
          if (valueDes == null) continue;
          result.age = valueDes;
          break;
        case r'sex':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateCaseRequestSexEnum),
          ) as UpdateCaseRequestSexEnum?;
          if (valueDes == null) continue;
          result.sex = valueDes;
          break;
        case r'persona':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.persona = valueDes;
          break;
        case r'tone_presets':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
          result.tonePresets.replace(valueDes);
          break;
        case r'chief_complaint':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.chiefComplaint = valueDes;
          break;
        case r'history_of_present_illness':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.historyOfPresentIllness = valueDes;
          break;
        case r'key_history_points':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(KeyHistoryPointsRequest),
          ) as KeyHistoryPointsRequest?;
          if (valueDes == null) continue;
          result.keyHistoryPoints.replace(valueDes);
          break;
        case r'final_diagnosis':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(String),
          ) as String?;
          if (valueDes == null) continue;
          result.finalDiagnosis = valueDes;
          break;
        case r'differential':
          final valueDes = serializers.deserialize(
            value,
            specifiedType:
                const FullType.nullable(BuiltList, [FullType(String)]),
          ) as BuiltList<String>?;
          if (valueDes == null) continue;
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
            specifiedType: const FullType.nullable(InvestigationsRequest),
          ) as InvestigationsRequest?;
          if (valueDes == null) continue;
          result.investigations.replace(valueDes);
          break;
        case r'management':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ManagementRequest),
          ) as ManagementRequest?;
          if (valueDes == null) continue;
          result.management.replace(valueDes);
          break;
        case r'scoring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(ScoringRequest),
          ) as ScoringRequest?;
          if (valueDes == null) continue;
          result.scoring.replace(valueDes);
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType.nullable(UpdateCaseRequestStatusEnum),
          ) as UpdateCaseRequestStatusEnum?;
          if (valueDes == null) continue;
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
  UpdateCaseRequest deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = UpdateCaseRequestBuilder();
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

class UpdateCaseRequestLanguageEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'en')
  static const UpdateCaseRequestLanguageEnum en =
      _$updateCaseRequestLanguageEnum_en;

  static Serializer<UpdateCaseRequestLanguageEnum> get serializer =>
      _$updateCaseRequestLanguageEnumSerializer;

  const UpdateCaseRequestLanguageEnum._(String name) : super(name);

  static BuiltSet<UpdateCaseRequestLanguageEnum> get values =>
      _$updateCaseRequestLanguageEnumValues;
  static UpdateCaseRequestLanguageEnum valueOf(String name) =>
      _$updateCaseRequestLanguageEnumValueOf(name);
}

class UpdateCaseRequestDifficultyEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'easy')
  static const UpdateCaseRequestDifficultyEnum easy =
      _$updateCaseRequestDifficultyEnum_easy;
  @BuiltValueEnumConst(wireName: r'medium')
  static const UpdateCaseRequestDifficultyEnum medium =
      _$updateCaseRequestDifficultyEnum_medium;
  @BuiltValueEnumConst(wireName: r'hard')
  static const UpdateCaseRequestDifficultyEnum hard =
      _$updateCaseRequestDifficultyEnum_hard;

  static Serializer<UpdateCaseRequestDifficultyEnum> get serializer =>
      _$updateCaseRequestDifficultyEnumSerializer;

  const UpdateCaseRequestDifficultyEnum._(String name) : super(name);

  static BuiltSet<UpdateCaseRequestDifficultyEnum> get values =>
      _$updateCaseRequestDifficultyEnumValues;
  static UpdateCaseRequestDifficultyEnum valueOf(String name) =>
      _$updateCaseRequestDifficultyEnumValueOf(name);
}

class UpdateCaseRequestSexEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'female')
  static const UpdateCaseRequestSexEnum female =
      _$updateCaseRequestSexEnum_female;
  @BuiltValueEnumConst(wireName: r'male')
  static const UpdateCaseRequestSexEnum male = _$updateCaseRequestSexEnum_male;
  @BuiltValueEnumConst(wireName: r'other')
  static const UpdateCaseRequestSexEnum other =
      _$updateCaseRequestSexEnum_other;

  static Serializer<UpdateCaseRequestSexEnum> get serializer =>
      _$updateCaseRequestSexEnumSerializer;

  const UpdateCaseRequestSexEnum._(String name) : super(name);

  static BuiltSet<UpdateCaseRequestSexEnum> get values =>
      _$updateCaseRequestSexEnumValues;
  static UpdateCaseRequestSexEnum valueOf(String name) =>
      _$updateCaseRequestSexEnumValueOf(name);
}

class UpdateCaseRequestStatusEnum extends EnumClass {
  @BuiltValueEnumConst(wireName: r'draft')
  static const UpdateCaseRequestStatusEnum draft =
      _$updateCaseRequestStatusEnum_draft;
  @BuiltValueEnumConst(wireName: r'review')
  static const UpdateCaseRequestStatusEnum review =
      _$updateCaseRequestStatusEnum_review;
  @BuiltValueEnumConst(wireName: r'published')
  static const UpdateCaseRequestStatusEnum published =
      _$updateCaseRequestStatusEnum_published;

  static Serializer<UpdateCaseRequestStatusEnum> get serializer =>
      _$updateCaseRequestStatusEnumSerializer;

  const UpdateCaseRequestStatusEnum._(String name) : super(name);

  static BuiltSet<UpdateCaseRequestStatusEnum> get values =>
      _$updateCaseRequestStatusEnumValues;
  static UpdateCaseRequestStatusEnum valueOf(String name) =>
      _$updateCaseRequestStatusEnumValueOf(name);
}
