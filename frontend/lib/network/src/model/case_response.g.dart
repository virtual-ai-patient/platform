// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'case_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CaseResponse extends CaseResponse {
  @override
  final String id;
  @override
  final String caseId;
  @override
  final String status;
  @override
  final int version;
  @override
  final String createdBy;
  @override
  final String title;
  @override
  final String language;
  @override
  final String difficulty;
  @override
  final String specialty;
  @override
  final BuiltList<String> tags;
  @override
  final int age;
  @override
  final String sex;
  @override
  final String persona;
  @override
  final BuiltList<String> tonePresets;
  @override
  final String chiefComplaint;
  @override
  final String historyOfPresentIllness;
  @override
  final KeyHistoryPointsResponse keyHistoryPoints;
  @override
  final String finalDiagnosis;
  @override
  final BuiltList<String> differential;
  @override
  final String? severityOrStage;
  @override
  final InvestigationsResponse investigations;
  @override
  final ManagementResponse management;
  @override
  final ScoringResponse scoring;

  factory _$CaseResponse([void Function(CaseResponseBuilder)? updates]) =>
      (CaseResponseBuilder()..update(updates))._build();

  _$CaseResponse._(
      {required this.id,
      required this.caseId,
      required this.status,
      required this.version,
      required this.createdBy,
      required this.title,
      required this.language,
      required this.difficulty,
      required this.specialty,
      required this.tags,
      required this.age,
      required this.sex,
      required this.persona,
      required this.tonePresets,
      required this.chiefComplaint,
      required this.historyOfPresentIllness,
      required this.keyHistoryPoints,
      required this.finalDiagnosis,
      required this.differential,
      this.severityOrStage,
      required this.investigations,
      required this.management,
      required this.scoring})
      : super._();
  @override
  CaseResponse rebuild(void Function(CaseResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  CaseResponseBuilder toBuilder() => CaseResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CaseResponse &&
        id == other.id &&
        caseId == other.caseId &&
        status == other.status &&
        version == other.version &&
        createdBy == other.createdBy &&
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
        scoring == other.scoring;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, id.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, version.hashCode);
    _$hash = $jc(_$hash, createdBy.hashCode);
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CaseResponse')
          ..add('id', id)
          ..add('caseId', caseId)
          ..add('status', status)
          ..add('version', version)
          ..add('createdBy', createdBy)
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
          ..add('scoring', scoring))
        .toString();
  }
}

class CaseResponseBuilder
    implements Builder<CaseResponse, CaseResponseBuilder> {
  _$CaseResponse? _$v;

  String? _id;
  String? get id => _$this._id;
  set id(String? id) => _$this._id = id;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  int? _version;
  int? get version => _$this._version;
  set version(int? version) => _$this._version = version;

  String? _createdBy;
  String? get createdBy => _$this._createdBy;
  set createdBy(String? createdBy) => _$this._createdBy = createdBy;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _language;
  String? get language => _$this._language;
  set language(String? language) => _$this._language = language;

  String? _difficulty;
  String? get difficulty => _$this._difficulty;
  set difficulty(String? difficulty) => _$this._difficulty = difficulty;

  String? _specialty;
  String? get specialty => _$this._specialty;
  set specialty(String? specialty) => _$this._specialty = specialty;

  ListBuilder<String>? _tags;
  ListBuilder<String> get tags => _$this._tags ??= ListBuilder<String>();
  set tags(ListBuilder<String>? tags) => _$this._tags = tags;

  int? _age;
  int? get age => _$this._age;
  set age(int? age) => _$this._age = age;

  String? _sex;
  String? get sex => _$this._sex;
  set sex(String? sex) => _$this._sex = sex;

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

  KeyHistoryPointsResponseBuilder? _keyHistoryPoints;
  KeyHistoryPointsResponseBuilder get keyHistoryPoints =>
      _$this._keyHistoryPoints ??= KeyHistoryPointsResponseBuilder();
  set keyHistoryPoints(KeyHistoryPointsResponseBuilder? keyHistoryPoints) =>
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

  InvestigationsResponseBuilder? _investigations;
  InvestigationsResponseBuilder get investigations =>
      _$this._investigations ??= InvestigationsResponseBuilder();
  set investigations(InvestigationsResponseBuilder? investigations) =>
      _$this._investigations = investigations;

  ManagementResponseBuilder? _management;
  ManagementResponseBuilder get management =>
      _$this._management ??= ManagementResponseBuilder();
  set management(ManagementResponseBuilder? management) =>
      _$this._management = management;

  ScoringResponseBuilder? _scoring;
  ScoringResponseBuilder get scoring =>
      _$this._scoring ??= ScoringResponseBuilder();
  set scoring(ScoringResponseBuilder? scoring) => _$this._scoring = scoring;

  CaseResponseBuilder() {
    CaseResponse._defaults(this);
  }

  CaseResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _id = $v.id;
      _caseId = $v.caseId;
      _status = $v.status;
      _version = $v.version;
      _createdBy = $v.createdBy;
      _title = $v.title;
      _language = $v.language;
      _difficulty = $v.difficulty;
      _specialty = $v.specialty;
      _tags = $v.tags.toBuilder();
      _age = $v.age;
      _sex = $v.sex;
      _persona = $v.persona;
      _tonePresets = $v.tonePresets.toBuilder();
      _chiefComplaint = $v.chiefComplaint;
      _historyOfPresentIllness = $v.historyOfPresentIllness;
      _keyHistoryPoints = $v.keyHistoryPoints.toBuilder();
      _finalDiagnosis = $v.finalDiagnosis;
      _differential = $v.differential.toBuilder();
      _severityOrStage = $v.severityOrStage;
      _investigations = $v.investigations.toBuilder();
      _management = $v.management.toBuilder();
      _scoring = $v.scoring.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CaseResponse other) {
    _$v = other as _$CaseResponse;
  }

  @override
  void update(void Function(CaseResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CaseResponse build() => _build();

  _$CaseResponse _build() {
    _$CaseResponse _$result;
    try {
      _$result = _$v ??
          _$CaseResponse._(
            id: BuiltValueNullFieldError.checkNotNull(
                id, r'CaseResponse', 'id'),
            caseId: BuiltValueNullFieldError.checkNotNull(
                caseId, r'CaseResponse', 'caseId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'CaseResponse', 'status'),
            version: BuiltValueNullFieldError.checkNotNull(
                version, r'CaseResponse', 'version'),
            createdBy: BuiltValueNullFieldError.checkNotNull(
                createdBy, r'CaseResponse', 'createdBy'),
            title: BuiltValueNullFieldError.checkNotNull(
                title, r'CaseResponse', 'title'),
            language: BuiltValueNullFieldError.checkNotNull(
                language, r'CaseResponse', 'language'),
            difficulty: BuiltValueNullFieldError.checkNotNull(
                difficulty, r'CaseResponse', 'difficulty'),
            specialty: BuiltValueNullFieldError.checkNotNull(
                specialty, r'CaseResponse', 'specialty'),
            tags: tags.build(),
            age: BuiltValueNullFieldError.checkNotNull(
                age, r'CaseResponse', 'age'),
            sex: BuiltValueNullFieldError.checkNotNull(
                sex, r'CaseResponse', 'sex'),
            persona: BuiltValueNullFieldError.checkNotNull(
                persona, r'CaseResponse', 'persona'),
            tonePresets: tonePresets.build(),
            chiefComplaint: BuiltValueNullFieldError.checkNotNull(
                chiefComplaint, r'CaseResponse', 'chiefComplaint'),
            historyOfPresentIllness: BuiltValueNullFieldError.checkNotNull(
                historyOfPresentIllness,
                r'CaseResponse',
                'historyOfPresentIllness'),
            keyHistoryPoints: keyHistoryPoints.build(),
            finalDiagnosis: BuiltValueNullFieldError.checkNotNull(
                finalDiagnosis, r'CaseResponse', 'finalDiagnosis'),
            differential: differential.build(),
            severityOrStage: severityOrStage,
            investigations: investigations.build(),
            management: management.build(),
            scoring: scoring.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tags';
        tags.build();

        _$failedField = 'tonePresets';
        tonePresets.build();

        _$failedField = 'keyHistoryPoints';
        keyHistoryPoints.build();

        _$failedField = 'differential';
        differential.build();

        _$failedField = 'investigations';
        investigations.build();
        _$failedField = 'management';
        management.build();
        _$failedField = 'scoring';
        scoring.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'CaseResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
