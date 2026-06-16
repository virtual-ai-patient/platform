// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'debrief_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DebriefResponse extends DebriefResponse {
  @override
  final String sessionId;
  @override
  final int caseVersion;
  @override
  final num totalScore;
  @override
  final num scoreDiagnosis;
  @override
  final num scoreDiagnostics;
  @override
  final num scoreTreatment;
  @override
  final num scoreSafety;
  @override
  final DateTime scoredAt;
  @override
  final BuiltList<EvaluationFindingResponse> findings;
  @override
  final BuiltMap<String, JsonObject?> referenceSolution;
  @override
  final BuiltMap<String, JsonObject?> conclusions;

  factory _$DebriefResponse([void Function(DebriefResponseBuilder)? updates]) =>
      (DebriefResponseBuilder()..update(updates))._build();

  _$DebriefResponse._(
      {required this.sessionId,
      required this.caseVersion,
      required this.totalScore,
      required this.scoreDiagnosis,
      required this.scoreDiagnostics,
      required this.scoreTreatment,
      required this.scoreSafety,
      required this.scoredAt,
      required this.findings,
      required this.referenceSolution,
      required this.conclusions})
      : super._();
  @override
  DebriefResponse rebuild(void Function(DebriefResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DebriefResponseBuilder toBuilder() => DebriefResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DebriefResponse &&
        sessionId == other.sessionId &&
        caseVersion == other.caseVersion &&
        totalScore == other.totalScore &&
        scoreDiagnosis == other.scoreDiagnosis &&
        scoreDiagnostics == other.scoreDiagnostics &&
        scoreTreatment == other.scoreTreatment &&
        scoreSafety == other.scoreSafety &&
        scoredAt == other.scoredAt &&
        findings == other.findings &&
        referenceSolution == other.referenceSolution &&
        conclusions == other.conclusions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, caseVersion.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, scoreDiagnosis.hashCode);
    _$hash = $jc(_$hash, scoreDiagnostics.hashCode);
    _$hash = $jc(_$hash, scoreTreatment.hashCode);
    _$hash = $jc(_$hash, scoreSafety.hashCode);
    _$hash = $jc(_$hash, scoredAt.hashCode);
    _$hash = $jc(_$hash, findings.hashCode);
    _$hash = $jc(_$hash, referenceSolution.hashCode);
    _$hash = $jc(_$hash, conclusions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DebriefResponse')
          ..add('sessionId', sessionId)
          ..add('caseVersion', caseVersion)
          ..add('totalScore', totalScore)
          ..add('scoreDiagnosis', scoreDiagnosis)
          ..add('scoreDiagnostics', scoreDiagnostics)
          ..add('scoreTreatment', scoreTreatment)
          ..add('scoreSafety', scoreSafety)
          ..add('scoredAt', scoredAt)
          ..add('findings', findings)
          ..add('referenceSolution', referenceSolution)
          ..add('conclusions', conclusions))
        .toString();
  }
}

class DebriefResponseBuilder
    implements Builder<DebriefResponse, DebriefResponseBuilder> {
  _$DebriefResponse? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  int? _caseVersion;
  int? get caseVersion => _$this._caseVersion;
  set caseVersion(int? caseVersion) => _$this._caseVersion = caseVersion;

  num? _totalScore;
  num? get totalScore => _$this._totalScore;
  set totalScore(num? totalScore) => _$this._totalScore = totalScore;

  num? _scoreDiagnosis;
  num? get scoreDiagnosis => _$this._scoreDiagnosis;
  set scoreDiagnosis(num? scoreDiagnosis) =>
      _$this._scoreDiagnosis = scoreDiagnosis;

  num? _scoreDiagnostics;
  num? get scoreDiagnostics => _$this._scoreDiagnostics;
  set scoreDiagnostics(num? scoreDiagnostics) =>
      _$this._scoreDiagnostics = scoreDiagnostics;

  num? _scoreTreatment;
  num? get scoreTreatment => _$this._scoreTreatment;
  set scoreTreatment(num? scoreTreatment) =>
      _$this._scoreTreatment = scoreTreatment;

  num? _scoreSafety;
  num? get scoreSafety => _$this._scoreSafety;
  set scoreSafety(num? scoreSafety) => _$this._scoreSafety = scoreSafety;

  DateTime? _scoredAt;
  DateTime? get scoredAt => _$this._scoredAt;
  set scoredAt(DateTime? scoredAt) => _$this._scoredAt = scoredAt;

  ListBuilder<EvaluationFindingResponse>? _findings;
  ListBuilder<EvaluationFindingResponse> get findings =>
      _$this._findings ??= ListBuilder<EvaluationFindingResponse>();
  set findings(ListBuilder<EvaluationFindingResponse>? findings) =>
      _$this._findings = findings;

  MapBuilder<String, JsonObject?>? _referenceSolution;
  MapBuilder<String, JsonObject?> get referenceSolution =>
      _$this._referenceSolution ??= MapBuilder<String, JsonObject?>();
  set referenceSolution(MapBuilder<String, JsonObject?>? referenceSolution) =>
      _$this._referenceSolution = referenceSolution;

  MapBuilder<String, JsonObject?>? _conclusions;
  MapBuilder<String, JsonObject?> get conclusions =>
      _$this._conclusions ??= MapBuilder<String, JsonObject?>();
  set conclusions(MapBuilder<String, JsonObject?>? conclusions) =>
      _$this._conclusions = conclusions;

  DebriefResponseBuilder() {
    DebriefResponse._defaults(this);
  }

  DebriefResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _caseVersion = $v.caseVersion;
      _totalScore = $v.totalScore;
      _scoreDiagnosis = $v.scoreDiagnosis;
      _scoreDiagnostics = $v.scoreDiagnostics;
      _scoreTreatment = $v.scoreTreatment;
      _scoreSafety = $v.scoreSafety;
      _scoredAt = $v.scoredAt;
      _findings = $v.findings.toBuilder();
      _referenceSolution = $v.referenceSolution.toBuilder();
      _conclusions = $v.conclusions.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DebriefResponse other) {
    _$v = other as _$DebriefResponse;
  }

  @override
  void update(void Function(DebriefResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DebriefResponse build() => _build();

  _$DebriefResponse _build() {
    _$DebriefResponse _$result;
    try {
      _$result = _$v ??
          _$DebriefResponse._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
                sessionId, r'DebriefResponse', 'sessionId'),
            caseVersion: BuiltValueNullFieldError.checkNotNull(
                caseVersion, r'DebriefResponse', 'caseVersion'),
            totalScore: BuiltValueNullFieldError.checkNotNull(
                totalScore, r'DebriefResponse', 'totalScore'),
            scoreDiagnosis: BuiltValueNullFieldError.checkNotNull(
                scoreDiagnosis, r'DebriefResponse', 'scoreDiagnosis'),
            scoreDiagnostics: BuiltValueNullFieldError.checkNotNull(
                scoreDiagnostics, r'DebriefResponse', 'scoreDiagnostics'),
            scoreTreatment: BuiltValueNullFieldError.checkNotNull(
                scoreTreatment, r'DebriefResponse', 'scoreTreatment'),
            scoreSafety: BuiltValueNullFieldError.checkNotNull(
                scoreSafety, r'DebriefResponse', 'scoreSafety'),
            scoredAt: BuiltValueNullFieldError.checkNotNull(
                scoredAt, r'DebriefResponse', 'scoredAt'),
            findings: findings.build(),
            referenceSolution: referenceSolution.build(),
            conclusions: conclusions.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'findings';
        findings.build();
        _$failedField = 'referenceSolution';
        referenceSolution.build();
        _$failedField = 'conclusions';
        conclusions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'DebriefResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
