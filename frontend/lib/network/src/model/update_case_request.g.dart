// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_case_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const UpdateCaseRequestLanguageEnum _$updateCaseRequestLanguageEnum_en =
    const UpdateCaseRequestLanguageEnum._('en');

UpdateCaseRequestLanguageEnum _$updateCaseRequestLanguageEnumValueOf(
    String name) {
  switch (name) {
    case 'en':
      return _$updateCaseRequestLanguageEnum_en;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateCaseRequestLanguageEnum>
    _$updateCaseRequestLanguageEnumValues = BuiltSet<
        UpdateCaseRequestLanguageEnum>(const <UpdateCaseRequestLanguageEnum>[
  _$updateCaseRequestLanguageEnum_en,
]);

const UpdateCaseRequestDifficultyEnum _$updateCaseRequestDifficultyEnum_easy =
    const UpdateCaseRequestDifficultyEnum._('easy');
const UpdateCaseRequestDifficultyEnum _$updateCaseRequestDifficultyEnum_medium =
    const UpdateCaseRequestDifficultyEnum._('medium');
const UpdateCaseRequestDifficultyEnum _$updateCaseRequestDifficultyEnum_hard =
    const UpdateCaseRequestDifficultyEnum._('hard');

UpdateCaseRequestDifficultyEnum _$updateCaseRequestDifficultyEnumValueOf(
    String name) {
  switch (name) {
    case 'easy':
      return _$updateCaseRequestDifficultyEnum_easy;
    case 'medium':
      return _$updateCaseRequestDifficultyEnum_medium;
    case 'hard':
      return _$updateCaseRequestDifficultyEnum_hard;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateCaseRequestDifficultyEnum>
    _$updateCaseRequestDifficultyEnumValues = BuiltSet<
        UpdateCaseRequestDifficultyEnum>(const <UpdateCaseRequestDifficultyEnum>[
  _$updateCaseRequestDifficultyEnum_easy,
  _$updateCaseRequestDifficultyEnum_medium,
  _$updateCaseRequestDifficultyEnum_hard,
]);

const UpdateCaseRequestSexEnum _$updateCaseRequestSexEnum_female =
    const UpdateCaseRequestSexEnum._('female');
const UpdateCaseRequestSexEnum _$updateCaseRequestSexEnum_male =
    const UpdateCaseRequestSexEnum._('male');
const UpdateCaseRequestSexEnum _$updateCaseRequestSexEnum_other =
    const UpdateCaseRequestSexEnum._('other');

UpdateCaseRequestSexEnum _$updateCaseRequestSexEnumValueOf(String name) {
  switch (name) {
    case 'female':
      return _$updateCaseRequestSexEnum_female;
    case 'male':
      return _$updateCaseRequestSexEnum_male;
    case 'other':
      return _$updateCaseRequestSexEnum_other;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateCaseRequestSexEnum> _$updateCaseRequestSexEnumValues =
    BuiltSet<UpdateCaseRequestSexEnum>(const <UpdateCaseRequestSexEnum>[
  _$updateCaseRequestSexEnum_female,
  _$updateCaseRequestSexEnum_male,
  _$updateCaseRequestSexEnum_other,
]);

const UpdateCaseRequestStatusEnum _$updateCaseRequestStatusEnum_draft =
    const UpdateCaseRequestStatusEnum._('draft');
const UpdateCaseRequestStatusEnum _$updateCaseRequestStatusEnum_review =
    const UpdateCaseRequestStatusEnum._('review');
const UpdateCaseRequestStatusEnum _$updateCaseRequestStatusEnum_published =
    const UpdateCaseRequestStatusEnum._('published');

UpdateCaseRequestStatusEnum _$updateCaseRequestStatusEnumValueOf(String name) {
  switch (name) {
    case 'draft':
      return _$updateCaseRequestStatusEnum_draft;
    case 'review':
      return _$updateCaseRequestStatusEnum_review;
    case 'published':
      return _$updateCaseRequestStatusEnum_published;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<UpdateCaseRequestStatusEnum>
    _$updateCaseRequestStatusEnumValues =
    BuiltSet<UpdateCaseRequestStatusEnum>(const <UpdateCaseRequestStatusEnum>[
  _$updateCaseRequestStatusEnum_draft,
  _$updateCaseRequestStatusEnum_review,
  _$updateCaseRequestStatusEnum_published,
]);

Serializer<UpdateCaseRequestLanguageEnum>
    _$updateCaseRequestLanguageEnumSerializer =
    _$UpdateCaseRequestLanguageEnumSerializer();
Serializer<UpdateCaseRequestDifficultyEnum>
    _$updateCaseRequestDifficultyEnumSerializer =
    _$UpdateCaseRequestDifficultyEnumSerializer();
Serializer<UpdateCaseRequestSexEnum> _$updateCaseRequestSexEnumSerializer =
    _$UpdateCaseRequestSexEnumSerializer();
Serializer<UpdateCaseRequestStatusEnum>
    _$updateCaseRequestStatusEnumSerializer =
    _$UpdateCaseRequestStatusEnumSerializer();

class _$UpdateCaseRequestLanguageEnumSerializer
    implements PrimitiveSerializer<UpdateCaseRequestLanguageEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'en': 'en',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'en': 'en',
  };

  @override
  final Iterable<Type> types = const <Type>[UpdateCaseRequestLanguageEnum];
  @override
  final String wireName = 'UpdateCaseRequestLanguageEnum';

  @override
  Object serialize(
          Serializers serializers, UpdateCaseRequestLanguageEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateCaseRequestLanguageEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateCaseRequestLanguageEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateCaseRequestDifficultyEnumSerializer
    implements PrimitiveSerializer<UpdateCaseRequestDifficultyEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateCaseRequestDifficultyEnum];
  @override
  final String wireName = 'UpdateCaseRequestDifficultyEnum';

  @override
  Object serialize(
          Serializers serializers, UpdateCaseRequestDifficultyEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateCaseRequestDifficultyEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateCaseRequestDifficultyEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateCaseRequestSexEnumSerializer
    implements PrimitiveSerializer<UpdateCaseRequestSexEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateCaseRequestSexEnum];
  @override
  final String wireName = 'UpdateCaseRequestSexEnum';

  @override
  Object serialize(Serializers serializers, UpdateCaseRequestSexEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateCaseRequestSexEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateCaseRequestSexEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateCaseRequestStatusEnumSerializer
    implements PrimitiveSerializer<UpdateCaseRequestStatusEnum> {
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
  final Iterable<Type> types = const <Type>[UpdateCaseRequestStatusEnum];
  @override
  final String wireName = 'UpdateCaseRequestStatusEnum';

  @override
  Object serialize(Serializers serializers, UpdateCaseRequestStatusEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  UpdateCaseRequestStatusEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      UpdateCaseRequestStatusEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$UpdateCaseRequest extends UpdateCaseRequest {
  @override
  final String? title;
  @override
  final UpdateCaseRequestLanguageEnum? language;
  @override
  final UpdateCaseRequestDifficultyEnum? difficulty;
  @override
  final String? specialty;
  @override
  final BuiltList<String>? tags;
  @override
  final int? age;
  @override
  final UpdateCaseRequestSexEnum? sex;
  @override
  final String? persona;
  @override
  final BuiltList<String>? tonePresets;
  @override
  final String? chiefComplaint;
  @override
  final String? historyOfPresentIllness;
  @override
  final KeyHistoryPointsRequest? keyHistoryPoints;
  @override
  final String? finalDiagnosis;
  @override
  final BuiltList<String>? differential;
  @override
  final String? severityOrStage;
  @override
  final InvestigationsRequest? investigations;
  @override
  final ManagementRequest? management;
  @override
  final ScoringRequest? scoring;
  @override
  final UpdateCaseRequestStatusEnum? status;

  factory _$UpdateCaseRequest(
          [void Function(UpdateCaseRequestBuilder)? updates]) =>
      (UpdateCaseRequestBuilder()..update(updates))._build();

  _$UpdateCaseRequest._(
      {this.title,
      this.language,
      this.difficulty,
      this.specialty,
      this.tags,
      this.age,
      this.sex,
      this.persona,
      this.tonePresets,
      this.chiefComplaint,
      this.historyOfPresentIllness,
      this.keyHistoryPoints,
      this.finalDiagnosis,
      this.differential,
      this.severityOrStage,
      this.investigations,
      this.management,
      this.scoring,
      this.status})
      : super._();
  @override
  UpdateCaseRequest rebuild(void Function(UpdateCaseRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  UpdateCaseRequestBuilder toBuilder() =>
      UpdateCaseRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is UpdateCaseRequest &&
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
    return (newBuiltValueToStringHelper(r'UpdateCaseRequest')
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

class UpdateCaseRequestBuilder
    implements Builder<UpdateCaseRequest, UpdateCaseRequestBuilder> {
  _$UpdateCaseRequest? _$v;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  UpdateCaseRequestLanguageEnum? _language;
  UpdateCaseRequestLanguageEnum? get language => _$this._language;
  set language(UpdateCaseRequestLanguageEnum? language) =>
      _$this._language = language;

  UpdateCaseRequestDifficultyEnum? _difficulty;
  UpdateCaseRequestDifficultyEnum? get difficulty => _$this._difficulty;
  set difficulty(UpdateCaseRequestDifficultyEnum? difficulty) =>
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

  UpdateCaseRequestSexEnum? _sex;
  UpdateCaseRequestSexEnum? get sex => _$this._sex;
  set sex(UpdateCaseRequestSexEnum? sex) => _$this._sex = sex;

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

  UpdateCaseRequestStatusEnum? _status;
  UpdateCaseRequestStatusEnum? get status => _$this._status;
  set status(UpdateCaseRequestStatusEnum? status) => _$this._status = status;

  UpdateCaseRequestBuilder() {
    UpdateCaseRequest._defaults(this);
  }

  UpdateCaseRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
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
      _keyHistoryPoints = $v.keyHistoryPoints?.toBuilder();
      _finalDiagnosis = $v.finalDiagnosis;
      _differential = $v.differential?.toBuilder();
      _severityOrStage = $v.severityOrStage;
      _investigations = $v.investigations?.toBuilder();
      _management = $v.management?.toBuilder();
      _scoring = $v.scoring?.toBuilder();
      _status = $v.status;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(UpdateCaseRequest other) {
    _$v = other as _$UpdateCaseRequest;
  }

  @override
  void update(void Function(UpdateCaseRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  UpdateCaseRequest build() => _build();

  _$UpdateCaseRequest _build() {
    _$UpdateCaseRequest _$result;
    try {
      _$result = _$v ??
          _$UpdateCaseRequest._(
            title: title,
            language: language,
            difficulty: difficulty,
            specialty: specialty,
            tags: _tags?.build(),
            age: age,
            sex: sex,
            persona: persona,
            tonePresets: _tonePresets?.build(),
            chiefComplaint: chiefComplaint,
            historyOfPresentIllness: historyOfPresentIllness,
            keyHistoryPoints: _keyHistoryPoints?.build(),
            finalDiagnosis: finalDiagnosis,
            differential: _differential?.build(),
            severityOrStage: severityOrStage,
            investigations: _investigations?.build(),
            management: _management?.build(),
            scoring: _scoring?.build(),
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
        _keyHistoryPoints?.build();

        _$failedField = 'differential';
        _differential?.build();

        _$failedField = 'investigations';
        _investigations?.build();
        _$failedField = 'management';
        _management?.build();
        _$failedField = 'scoring';
        _scoring?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'UpdateCaseRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
