// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scores_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoresResponse extends ScoresResponse {
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

  factory _$ScoresResponse([void Function(ScoresResponseBuilder)? updates]) =>
      (ScoresResponseBuilder()..update(updates))._build();

  _$ScoresResponse._({
    required this.sessionId,
    required this.caseVersion,
    required this.totalScore,
    required this.scoreDiagnosis,
    required this.scoreDiagnostics,
    required this.scoreTreatment,
    required this.scoreSafety,
    required this.scoredAt,
  }) : super._();
  @override
  ScoresResponse rebuild(void Function(ScoresResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoresResponseBuilder toBuilder() => ScoresResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoresResponse &&
        sessionId == other.sessionId &&
        caseVersion == other.caseVersion &&
        totalScore == other.totalScore &&
        scoreDiagnosis == other.scoreDiagnosis &&
        scoreDiagnostics == other.scoreDiagnostics &&
        scoreTreatment == other.scoreTreatment &&
        scoreSafety == other.scoreSafety &&
        scoredAt == other.scoredAt;
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
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoresResponse')
          ..add('sessionId', sessionId)
          ..add('caseVersion', caseVersion)
          ..add('totalScore', totalScore)
          ..add('scoreDiagnosis', scoreDiagnosis)
          ..add('scoreDiagnostics', scoreDiagnostics)
          ..add('scoreTreatment', scoreTreatment)
          ..add('scoreSafety', scoreSafety)
          ..add('scoredAt', scoredAt))
        .toString();
  }
}

class ScoresResponseBuilder
    implements Builder<ScoresResponse, ScoresResponseBuilder> {
  _$ScoresResponse? _$v;

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

  ScoresResponseBuilder() {
    ScoresResponse._defaults(this);
  }

  ScoresResponseBuilder get _$this {
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
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoresResponse other) {
    _$v = other as _$ScoresResponse;
  }

  @override
  void update(void Function(ScoresResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoresResponse build() => _build();

  _$ScoresResponse _build() {
    final _$result =
        _$v ??
        _$ScoresResponse._(
          sessionId: BuiltValueNullFieldError.checkNotNull(
            sessionId,
            r'ScoresResponse',
            'sessionId',
          ),
          caseVersion: BuiltValueNullFieldError.checkNotNull(
            caseVersion,
            r'ScoresResponse',
            'caseVersion',
          ),
          totalScore: BuiltValueNullFieldError.checkNotNull(
            totalScore,
            r'ScoresResponse',
            'totalScore',
          ),
          scoreDiagnosis: BuiltValueNullFieldError.checkNotNull(
            scoreDiagnosis,
            r'ScoresResponse',
            'scoreDiagnosis',
          ),
          scoreDiagnostics: BuiltValueNullFieldError.checkNotNull(
            scoreDiagnostics,
            r'ScoresResponse',
            'scoreDiagnostics',
          ),
          scoreTreatment: BuiltValueNullFieldError.checkNotNull(
            scoreTreatment,
            r'ScoresResponse',
            'scoreTreatment',
          ),
          scoreSafety: BuiltValueNullFieldError.checkNotNull(
            scoreSafety,
            r'ScoresResponse',
            'scoreSafety',
          ),
          scoredAt: BuiltValueNullFieldError.checkNotNull(
            scoredAt,
            r'ScoresResponse',
            'scoredAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
