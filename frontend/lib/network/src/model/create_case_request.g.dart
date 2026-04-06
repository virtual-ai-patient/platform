// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_case_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const CreateCaseRequestLanguageEnum _$createCaseRequestLanguageEnum_en =
    const CreateCaseRequestLanguageEnum._('en');

CreateCaseRequestLanguageEnum _$createCaseRequestLanguageEnumValueOf(
    String name) {
  switch (name) {
    case 'en':
      return _$createCaseRequestLanguageEnum_en;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateCaseRequestLanguageEnum>
    _$createCaseRequestLanguageEnumValues = BuiltSet<
        CreateCaseRequestLanguageEnum>(const <CreateCaseRequestLanguageEnum>[
  _$createCaseRequestLanguageEnum_en,
]);

const CreateCaseRequestDifficultyEnum _$createCaseRequestDifficultyEnum_easy =
    const CreateCaseRequestDifficultyEnum._('easy');
const CreateCaseRequestDifficultyEnum _$createCaseRequestDifficultyEnum_medium =
    const CreateCaseRequestDifficultyEnum._('medium');
const CreateCaseRequestDifficultyEnum _$createCaseRequestDifficultyEnum_hard =
    const CreateCaseRequestDifficultyEnum._('hard');

CreateCaseRequestDifficultyEnum _$createCaseRequestDifficultyEnumValueOf(
    String name) {
  switch (name) {
    case 'easy':
      return _$createCaseRequestDifficultyEnum_easy;
    case 'medium':
      return _$createCaseRequestDifficultyEnum_medium;
    case 'hard':
      return _$createCaseRequestDifficultyEnum_hard;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateCaseRequestDifficultyEnum>
    _$createCaseRequestDifficultyEnumValues = BuiltSet<
        CreateCaseRequestDifficultyEnum>(const <CreateCaseRequestDifficultyEnum>[
  _$createCaseRequestDifficultyEnum_easy,
  _$createCaseRequestDifficultyEnum_medium,
  _$createCaseRequestDifficultyEnum_hard,
]);

const CreateCaseRequestSexEnum _$createCaseRequestSexEnum_female =
    const CreateCaseRequestSexEnum._('female');
const CreateCaseRequestSexEnum _$createCaseRequestSexEnum_male =
    const CreateCaseRequestSexEnum._('male');
const CreateCaseRequestSexEnum _$createCaseRequestSexEnum_other =
    const CreateCaseRequestSexEnum._('other');

CreateCaseRequestSexEnum _$createCaseRequestSexEnumValueOf(String name) {
  switch (name) {
    case 'female':
      return _$createCaseRequestSexEnum_female;
    case 'male':
      return _$createCaseRequestSexEnum_male;
    case 'other':
      return _$createCaseRequestSexEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateCaseRequestSexEnum> _$createCaseRequestSexEnumValues =
    BuiltSet<CreateCaseRequestSexEnum>(const <CreateCaseRequestSexEnum>[
  _$createCaseRequestSexEnum_female,
  _$createCaseRequestSexEnum_male,
  _$createCaseRequestSexEnum_other,
]);

const CreateCaseRequestStatusEnum _$createCaseRequestStatusEnum_draft =
    const CreateCaseRequestStatusEnum._('draft');
const CreateCaseRequestStatusEnum _$createCaseRequestStatusEnum_review =
    const CreateCaseRequestStatusEnum._('review');
const CreateCaseRequestStatusEnum _$createCaseRequestStatusEnum_published =
    const CreateCaseRequestStatusEnum._('published');

CreateCaseRequestStatusEnum _$createCaseRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'draft':
      return _$createCaseRequestStatusEnum_draft;
    case 'review':
      return _$createCaseRequestStatusEnum_review;
    case 'published':
      return _$createCaseRequestStatusEnum_published;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<CreateCaseRequestStatusEnum>
    _$createCaseRequestStatusEnumValues =
    BuiltSet<CreateCaseRequestStatusEnum>(const <CreateCaseRequestStatusEnum>[
  _$createCaseRequestStatusEnum_draft,
  _$createCaseRequestStatusEnum_review,
  _$createCaseRequestStatusEnum_published,
]);

Serializer<CreateCaseRequestLanguageEnum>
    _$createCaseRequestLanguageEnumSerializer =
    _$CreateCaseRequestLanguageEnumSerializer();
Serializer<CreateCaseRequestDifficultyEnum>
    _$createCaseRequestDifficultyEnumSerializer =
    _$CreateCaseRequestDifficultyEnumSerializer();
Serializer<CreateCaseRequestSexEnum> _$createCaseRequestSexEnumSerializer =
    _$CreateCaseRequestSexEnumSerializer();
Serializer<CreateCaseRequestStatusEnum>
    _$createCaseRequestStatusEnumSerializer =
    _$CreateCaseRequestStatusEnumSerializer();

class _$CreateCaseRequestLanguageEnumSerializer
    implements PrimitiveSerializer<CreateCaseRequestLanguageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'en': 'en',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'en': 'en',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateCaseRequestLanguageEnum];
  @override
  final String wireName = 'CreateCaseRequestLanguageEnum';

  @override
  Object serialize(
          Serializers serializers, CreateCaseRequestLanguageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateCaseRequestLanguageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateCaseRequestLanguageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateCaseRequestDifficultyEnumSerializer
    implements PrimitiveSerializer<CreateCaseRequestDifficultyEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'easy': 'easy',
    'medium': 'medium',
    'hard': 'hard',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'easy': 'easy',
    'medium': 'medium',
    'hard': 'hard',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateCaseRequestDifficultyEnum];
  @override
  final String wireName = 'CreateCaseRequestDifficultyEnum';

  @override
  Object serialize(
          Serializers serializers, CreateCaseRequestDifficultyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateCaseRequestDifficultyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateCaseRequestDifficultyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateCaseRequestSexEnumSerializer
    implements PrimitiveSerializer<CreateCaseRequestSexEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'female': 'female',
    'male': 'male',
    'other': 'other',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'female': 'female',
    'male': 'male',
    'other': 'other',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateCaseRequestSexEnum];
  @override
  final String wireName = 'CreateCaseRequestSexEnum';

  @override
  Object serialize(Serializers serializers, CreateCaseRequestSexEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateCaseRequestSexEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateCaseRequestSexEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateCaseRequestStatusEnumSerializer
    implements PrimitiveSerializer<CreateCaseRequestStatusEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'draft': 'draft',
    'review': 'review',
    'published': 'published',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'draft': 'draft',
    'review': 'review',
    'published': 'published',
  };

  @override
  final Iterable<Type> types = const <Type>[CreateCaseRequestStatusEnum];
  @override
  final String wireName = 'CreateCaseRequestStatusEnum';

  @override
  Object serialize(Serializers serializers, CreateCaseRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  CreateCaseRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      CreateCaseRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$CreateCaseRequest extends CreateCaseRequest {
  @override
  final String caseId;
  @override
  final String title;
  @override
  final CreateCaseRequestLanguageEnum language;
  @override
  final CreateCaseRequestDifficultyEnum difficulty;
  @override
  final String specialty;
  @override
  final BuiltList<String>? tags;
  @override
  final int age;
  @override
  final CreateCaseRequestSexEnum sex;
  @override
  final String persona;
  @override
  final BuiltList<String>? tonePresets;
  @override
  final String chiefComplaint;
  @override
  final String historyOfPresentIllness;
  @override
  final KeyHistoryPointsRequest keyHistoryPoints;
  @override
  final String finalDiagnosis;
  @override
  final BuiltList<String>? differential;
  @override
  final String? severityOrStage;
  @override
  final InvestigationsRequest investigations;
  @override
  final ManagementRequest management;
  @override
  final ScoringRequest scoring;
  @override
  final CreateCaseRequestStatusEnum? status;

  factory _$CreateCaseRequest(
          [void Function(CreateCaseRequestBuilder)? updates]) =>
      (CreateCaseRequestBuilder()..update(updates))._build();

  _$CreateCaseRequest._(
      {required this.caseId,
      required this.title,
      required this.language,
      required this.difficulty,
      required this.specialty,
      this.tags,
      required this.age,
      required this.sex,
      required this.persona,
      this.tonePresets,
      required this.chiefComplaint,
      required this.historyOfPresentIllness,
      required this.keyHistoryPoints,
      required this.finalDiagnosis,
      this.differential,
      this.severityOrStage,
      required this.investigations,
      required this.management,
      required this.scoring,
      this.status})
      : super._();
  @override
  CreateCaseRequest rebuild(void Function(CreateCaseRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CreateCaseRequestBuilder toBuilder() =>
      CreateCaseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CreateCaseRequest &&
        caseId == other.caseId &&
        title == other.title &&
        language == other.language &&
        difficulty == other.difficulty &&
        specialty == other.specialty &&
        tags == other.tags &&
        age == other.age &&
        sex == other.sex &&
        persona == other.persona &&
        tonePresets == other.tonePresets &&
        chiefComplaint == other.chiefComplaint &&
        historyOfPresentIllness == other.historyOfPresentIllness &&
        keyHistoryPoints == other.keyHistoryPoints &&
        finalDiagnosis == other.finalDiagnosis &&
        differential == other.differential &&
        severityOrStage == other.severityOrStage &&
        investigations == other.investigations &&
        management == other.management &&
        scoring == other.scoring &&
        status == other.status;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, title.hashCode);
    _$hash = $jc(_$hash, language.hashCode);
    _$hash = $jc(_$hash, difficulty.hashCode);
    _$hash = $jc(_$hash, specialty.hashCode);
    _$hash = $jc(_$hash, tags.hashCode);
    _$hash = $jc(_$hash, age.hashCode);
    _$hash = $jc(_$hash, sex.hashCode);
    _$hash = $jc(_$hash, persona.hashCode);
    _$hash = $jc(_$hash, tonePresets.hashCode);
    _$hash = $jc(_$hash, chiefComplaint.hashCode);
    _$hash = $jc(_$hash, historyOfPresentIllness.hashCode);
    _$hash = $jc(_$hash, keyHistoryPoints.hashCode);
    _$hash = $jc(_$hash, finalDiagnosis.hashCode);
    _$hash = $jc(_$hash, differential.hashCode);
    _$hash = $jc(_$hash, severityOrStage.hashCode);
    _$hash = $jc(_$hash, investigations.hashCode);
    _$hash = $jc(_$hash, management.hashCode);
    _$hash = $jc(_$hash, scoring.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CreateCaseRequest')
          ..add('caseId', caseId)
          ..add('title', title)
          ..add('language', language)
          ..add('difficulty', difficulty)
          ..add('specialty', specialty)
          ..add('tags', tags)
          ..add('age', age)
          ..add('sex', sex)
          ..add('persona', persona)
          ..add('tonePresets', tonePresets)
          ..add('chiefComplaint', chiefComplaint)
          ..add('historyOfPresentIllness', historyOfPresentIllness)
          ..add('keyHistoryPoints', keyHistoryPoints)
          ..add('finalDiagnosis', finalDiagnosis)
          ..add('differential', differential)
          ..add('severityOrStage', severityOrStage)
          ..add('investigations', investigations)
          ..add('management', management)
          ..add('scoring', scoring)
          ..add('status', status))
        .toString();
  }
}

class CreateCaseRequestBuilder
    implements Builder<CreateCaseRequest, CreateCaseRequestBuilder> {
  _$CreateCaseRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  CreateCaseRequestLanguageEnum? _language;
  CreateCaseRequestLanguageEnum? get language => _$this._language;
  set language(CreateCaseRequestLanguageEnum? language) =>
      _$this._language = language;

  CreateCaseRequestDifficultyEnum? _difficulty;
  CreateCaseRequestDifficultyEnum? get difficulty => _$this._difficulty;
  set difficulty(CreateCaseRequestDifficultyEnum? difficulty) =>
      _$this._difficulty = difficulty;

  String? _specialty;
  String? get specialty => _$this._specialty;
  set specialty(String? specialty) => _$this._specialty = specialty;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  CreateCaseRequestSexEnum? _sex;
  CreateCaseRequestSexEnum? get sex => _$this._sex;
  set sex(CreateCaseRequestSexEnum? sex) => _$this._sex = sex;

  String? _persona;
  String? get persona => _$this._persona;
  set persona(String? persona) => _$this._persona = persona;

  ListBuilder<String>? _tonePresets;
  ListBuilder<String> get tonePresets =>
      _$this._tonePresets ??= ListBuilder<String>();
  set tonePresets(ListBuilder<String>? tonePresets) =>
      _$this._tonePresets = tonePresets;

  String? _chiefComplaint;
  String? get chiefComplaint => _$this._chiefComplaint;
  set chiefComplaint(String? chiefComplaint) =>
      _$this._chiefComplaint = chiefComplaint;

  String? _historyOfPresentIllness;
  String? get historyOfPresentIllness => _$this._historyOfPresentIllness;
  set historyOfPresentIllness(String? historyOfPresentIllness) =>
      _$this._historyOfPresentIllness = historyOfPresentIllness;

  KeyHistoryPointsRequestBuilder? _keyHistoryPoints;
  KeyHistoryPointsRequestBuilder get keyHistoryPoints =>
      _$this._keyHistoryPoints ??= KeyHistoryPointsRequestBuilder();
  set keyHistoryPoints(KeyHistoryPointsRequestBuilder? keyHistoryPoints) =>
      _$this._keyHistoryPoints = keyHistoryPoints;

  String? _finalDiagnosis;
  String? get finalDiagnosis => _$this._finalDiagnosis;
  set finalDiagnosis(String? finalDiagnosis) =>
      _$this._finalDiagnosis = finalDiagnosis;

  ListBuilder<String>? _differential;
  ListBuilder<String> get differential =>
      _$this._differential ??= ListBuilder<String>();
  set differential(ListBuilder<String>? differential) =>
      _$this._differential = differential;

  String? _severityOrStage;
  String? get severityOrStage => _$this._severityOrStage;
  set severityOrStage(String? severityOrStage) =>
      _$this._severityOrStage = severityOrStage;

  InvestigationsRequestBuilder? _investigations;
  InvestigationsRequestBuilder get investigations =>
      _$this._investigations ??= InvestigationsRequestBuilder();
  set investigations(InvestigationsRequestBuilder? investigations) =>
      _$this._investigations = investigations;

  ManagementRequestBuilder? _management;
  ManagementRequestBuilder get management =>
      _$this._management ??= ManagementRequestBuilder();
  set management(ManagementRequestBuilder? management) =>
      _$this._management = management;

  ScoringRequestBuilder? _scoring;
  ScoringRequestBuilder get scoring =>
      _$this._scoring ??= ScoringRequestBuilder();
  set scoring(ScoringRequestBuilder? scoring) => _$this._scoring = scoring;

  CreateCaseRequestStatusEnum? _status;
  CreateCaseRequestStatusEnum? get status => _$this._status;
  set status(CreateCaseRequestStatusEnum? status) => _$this._status = status;

  CreateCaseRequestBuilder() {
    CreateCaseRequest._defaults(this);
  }

  CreateCaseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caseId = $v.caseId;
      _title = $v.title;
      _language = $v.language;
      _difficulty = $v.difficulty;
      _specialty = $v.specialty;
      _tags = $v.tags?.toBuilder();
      _age = $v.age;
      _sex = $v.sex;
      _persona = $v.persona;
      _tonePresets = $v.tonePresets?.toBuilder();
      _chiefComplaint = $v.chiefComplaint;
      _historyOfPresentIllness = $v.historyOfPresentIllness;
      _keyHistoryPoints = $v.keyHistoryPoints.toBuilder();
      _finalDiagnosis = $v.finalDiagnosis;
      _differential = $v.differential?.toBuilder();
      _severityOrStage = $v.severityOrStage;
      _investigations = $v.investigations.toBuilder();
      _management = $v.management.toBuilder();
      _scoring = $v.scoring.toBuilder();
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CreateCaseRequest other) {
    _$v = other as _$CreateCaseRequest;
  }

  @override
  void update(void Function(CreateCaseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CreateCaseRequest build() => _build();

  _$CreateCaseRequest _build() {
    _$CreateCaseRequest _$result;
    try {
      _$result = _$v ??
          _$CreateCaseRequest._(
            caseId: BuiltValueNullFieldError.checkNotNull(
                caseId, r'CreateCaseRequest', 'caseId'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'CreateCaseRequest', 'title'),
            language: BuiltValueNullFieldError.checkNotNull(
                language, r'CreateCaseRequest', 'language'),
            difficulty: BuiltValueNullFieldError.checkNotNull(
                difficulty, r'CreateCaseRequest', 'difficulty'),
            specialty: BuiltValueNullFieldError.checkNotNull(
                specialty, r'CreateCaseRequest', 'specialty'),
            tags: _tags?.build(),
            age: BuiltValueNullFieldError.checkNotNull(
                age, r'CreateCaseRequest', 'age'),
            sex: BuiltValueNullFieldError.checkNotNull(
                sex, r'CreateCaseRequest', 'sex'),
            persona: BuiltValueNullFieldError.checkNotNull(
                persona, r'CreateCaseRequest', 'persona'),
            tonePresets: _tonePresets?.build(),
            chiefComplaint: BuiltValueNullFieldError.checkNotNull(
                chiefComplaint, r'CreateCaseRequest', 'chiefComplaint'),
            historyOfPresentIllness: BuiltValueNullFieldError.checkNotNull(
                historyOfPresentIllness,
                r'CreateCaseRequest',
                'historyOfPresentIllness'),
            keyHistoryPoints: keyHistoryPoints.build(),
            finalDiagnosis: BuiltValueNullFieldError.checkNotNull(
                finalDiagnosis, r'CreateCaseRequest', 'finalDiagnosis'),
            differential: _differential?.build(),
            severityOrStage: severityOrStage,
            investigations: investigations.build(),
            management: management.build(),
            scoring: scoring.build(),
            status: status,
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        _tags?.build();

        _$failedField = 'tonePresets';
        _tonePresets?.build();

        _$failedField = 'keyHistoryPoints';
        keyHistoryPoints.build();

        _$failedField = 'differential';
        _differential?.build();

        _$failedField = 'investigations';
        investigations.build();
        _$failedField = 'management';
        management.build();
        _$failedField = 'scoring';
        scoring.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CreateCaseRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
