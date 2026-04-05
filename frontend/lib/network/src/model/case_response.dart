//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:frontend/network/src/model/management_response.dart';
import 'package:built_collection/built_collection.dart';
import 'package:frontend/network/src/model/scoring_response.dart';
import 'package:frontend/network/src/model/key_history_points_response.dart';
import 'package:frontend/network/src/model/investigations_response.dart';
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';

part 'case_response.g.dart';

/// CaseResponse
///
/// Properties:
/// * [id] 
/// * [caseId] 
/// * [status] 
/// * [version] 
/// * [createdBy] 
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
@BuiltValue()
abstract class CaseResponse implements Built<CaseResponse, CaseResponseBuilder> {
  @BuiltValueField(wireName: r'id')
  String get id;

  @BuiltValueField(wireName: r'case_id')
  String get caseId;

  @BuiltValueField(wireName: r'status')
  String get status;

  @BuiltValueField(wireName: r'version')
  int get version;

  @BuiltValueField(wireName: r'created_by')
  String get createdBy;

  @BuiltValueField(wireName: r'title')
  String get title;

  @BuiltValueField(wireName: r'language')
  String get language;

  @BuiltValueField(wireName: r'difficulty')
  String get difficulty;

  @BuiltValueField(wireName: r'specialty')
  String get specialty;

  @BuiltValueField(wireName: r'tags')
  BuiltList<String> get tags;

  @BuiltValueField(wireName: r'age')
  int get age;

  @BuiltValueField(wireName: r'sex')
  String get sex;

  @BuiltValueField(wireName: r'persona')
  String get persona;

  @BuiltValueField(wireName: r'tone_presets')
  BuiltList<String> get tonePresets;

  @BuiltValueField(wireName: r'chief_complaint')
  String get chiefComplaint;

  @BuiltValueField(wireName: r'history_of_present_illness')
  String get historyOfPresentIllness;

  @BuiltValueField(wireName: r'key_history_points')
  KeyHistoryPointsResponse get keyHistoryPoints;

  @BuiltValueField(wireName: r'final_diagnosis')
  String get finalDiagnosis;

  @BuiltValueField(wireName: r'differential')
  BuiltList<String> get differential;

  @BuiltValueField(wireName: r'severity_or_stage')
  String? get severityOrStage;

  @BuiltValueField(wireName: r'investigations')
  InvestigationsResponse get investigations;

  @BuiltValueField(wireName: r'management')
  ManagementResponse get management;

  @BuiltValueField(wireName: r'scoring')
  ScoringResponse get scoring;

  CaseResponse._();

  factory CaseResponse([void updates(CaseResponseBuilder b)]) = _$CaseResponse;

  @BuiltValueHook(initializeBuilder: true)
  static void _defaults(CaseResponseBuilder b) => b;

  @BuiltValueSerializer(custom: true)
  static Serializer<CaseResponse> get serializer => _$CaseResponseSerializer();
}

class _$CaseResponseSerializer implements PrimitiveSerializer<CaseResponse> {
  @override
  final Iterable<Type> types = const [CaseResponse, _$CaseResponse];

  @override
  final String wireName = r'CaseResponse';

  Iterable<Object?> _serializeProperties(
    Serializers serializers,
    CaseResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) sync* {
    yield r'id';
    yield serializers.serialize(
      object.id,
      specifiedType: const FullType(String),
    );
    yield r'case_id';
    yield serializers.serialize(
      object.caseId,
      specifiedType: const FullType(String),
    );
    yield r'status';
    yield serializers.serialize(
      object.status,
      specifiedType: const FullType(String),
    );
    yield r'version';
    yield serializers.serialize(
      object.version,
      specifiedType: const FullType(int),
    );
    yield r'created_by';
    yield serializers.serialize(
      object.createdBy,
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
      specifiedType: const FullType(String),
    );
    yield r'difficulty';
    yield serializers.serialize(
      object.difficulty,
      specifiedType: const FullType(String),
    );
    yield r'specialty';
    yield serializers.serialize(
      object.specialty,
      specifiedType: const FullType(String),
    );
    yield r'tags';
    yield serializers.serialize(
      object.tags,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'age';
    yield serializers.serialize(
      object.age,
      specifiedType: const FullType(int),
    );
    yield r'sex';
    yield serializers.serialize(
      object.sex,
      specifiedType: const FullType(String),
    );
    yield r'persona';
    yield serializers.serialize(
      object.persona,
      specifiedType: const FullType(String),
    );
    yield r'tone_presets';
    yield serializers.serialize(
      object.tonePresets,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
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
      specifiedType: const FullType(KeyHistoryPointsResponse),
    );
    yield r'final_diagnosis';
    yield serializers.serialize(
      object.finalDiagnosis,
      specifiedType: const FullType(String),
    );
    yield r'differential';
    yield serializers.serialize(
      object.differential,
      specifiedType: const FullType(BuiltList, [FullType(String)]),
    );
    yield r'severity_or_stage';
    yield object.severityOrStage == null ? null : serializers.serialize(
      object.severityOrStage,
      specifiedType: const FullType.nullable(String),
    );
    yield r'investigations';
    yield serializers.serialize(
      object.investigations,
      specifiedType: const FullType(InvestigationsResponse),
    );
    yield r'management';
    yield serializers.serialize(
      object.management,
      specifiedType: const FullType(ManagementResponse),
    );
    yield r'scoring';
    yield serializers.serialize(
      object.scoring,
      specifiedType: const FullType(ScoringResponse),
    );
  }

  @override
  Object serialize(
    Serializers serializers,
    CaseResponse object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return _serializeProperties(serializers, object, specifiedType: specifiedType).toList();
  }

  void _deserializeProperties(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
    required List<Object?> serializedList,
    required CaseResponseBuilder result,
    required List<Object?> unhandled,
  }) {
    for (var i = 0; i < serializedList.length; i += 2) {
      final key = serializedList[i] as String;
      final value = serializedList[i + 1];
      switch (key) {
        case r'id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.id = valueDes;
          break;
        case r'case_id':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.caseId = valueDes;
          break;
        case r'status':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.status = valueDes;
          break;
        case r'version':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(int),
          ) as int;
          result.version = valueDes;
          break;
        case r'created_by':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
          result.createdBy = valueDes;
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
            specifiedType: const FullType(String),
          ) as String;
          result.language = valueDes;
          break;
        case r'difficulty':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(String),
          ) as String;
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
            specifiedType: const FullType(KeyHistoryPointsResponse),
          ) as KeyHistoryPointsResponse;
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
            specifiedType: const FullType(InvestigationsResponse),
          ) as InvestigationsResponse;
          result.investigations.replace(valueDes);
          break;
        case r'management':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ManagementResponse),
          ) as ManagementResponse;
          result.management.replace(valueDes);
          break;
        case r'scoring':
          final valueDes = serializers.deserialize(
            value,
            specifiedType: const FullType(ScoringResponse),
          ) as ScoringResponse;
          result.scoring.replace(valueDes);
          break;
        default:
          unhandled.add(key);
          unhandled.add(value);
          break;
      }
    }
  }

  @override
  CaseResponse deserialize(
    Serializers serializers,
    Object serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = CaseResponseBuilder();
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

