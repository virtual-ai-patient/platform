// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoring_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoringResponse extends ScoringResponse {
  @override
  final num weightDiagnosis;
  @override
  final num weightDiagnostics;
  @override
  final num weightTreatment;
  @override
  final num weightSafety;
  @override
  final BuiltList<AcceptableAnswerResponse> acceptableAnswers;
  @override
  final BuiltList<String> criticalSafetyErrors;

  factory _$ScoringResponse([void Function(ScoringResponseBuilder)? updates]) =>
      (ScoringResponseBuilder()..update(updates))._build();

  _$ScoringResponse._(
      {required this.weightDiagnosis,
      required this.weightDiagnostics,
      required this.weightTreatment,
      required this.weightSafety,
      required this.acceptableAnswers,
      required this.criticalSafetyErrors})
      : super._();
  @override
  ScoringResponse rebuild(void Function(ScoringResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoringResponseBuilder toBuilder() => ScoringResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoringResponse &&
        weightDiagnosis == other.weightDiagnosis &&
        weightDiagnostics == other.weightDiagnostics &&
        weightTreatment == other.weightTreatment &&
        weightSafety == other.weightSafety &&
        acceptableAnswers == other.acceptableAnswers &&
        criticalSafetyErrors == other.criticalSafetyErrors;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, weightDiagnosis.hashCode);
    _$hash = $jc(_$hash, weightDiagnostics.hashCode);
    _$hash = $jc(_$hash, weightTreatment.hashCode);
    _$hash = $jc(_$hash, weightSafety.hashCode);
    _$hash = $jc(_$hash, acceptableAnswers.hashCode);
    _$hash = $jc(_$hash, criticalSafetyErrors.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ScoringResponse')
          ..add('weightDiagnosis', weightDiagnosis)
          ..add('weightDiagnostics', weightDiagnostics)
          ..add('weightTreatment', weightTreatment)
          ..add('weightSafety', weightSafety)
          ..add('acceptableAnswers', acceptableAnswers)
          ..add('criticalSafetyErrors', criticalSafetyErrors))
        .toString();
  }
}

class ScoringResponseBuilder
    implements Builder<ScoringResponse, ScoringResponseBuilder> {
  _$ScoringResponse? _$v;

  num? _weightDiagnosis;
  num? get weightDiagnosis => _$this._weightDiagnosis;
  set weightDiagnosis(num? weightDiagnosis) =>
      _$this._weightDiagnosis = weightDiagnosis;

  num? _weightDiagnostics;
  num? get weightDiagnostics => _$this._weightDiagnostics;
  set weightDiagnostics(num? weightDiagnostics) =>
      _$this._weightDiagnostics = weightDiagnostics;

  num? _weightTreatment;
  num? get weightTreatment => _$this._weightTreatment;
  set weightTreatment(num? weightTreatment) =>
      _$this._weightTreatment = weightTreatment;

  num? _weightSafety;
  num? get weightSafety => _$this._weightSafety;
  set weightSafety(num? weightSafety) => _$this._weightSafety = weightSafety;

  ListBuilder<AcceptableAnswerResponse>? _acceptableAnswers;
  ListBuilder<AcceptableAnswerResponse> get acceptableAnswers =>
      _$this._acceptableAnswers ??= ListBuilder<AcceptableAnswerResponse>();
  set acceptableAnswers(
          ListBuilder<AcceptableAnswerResponse>? acceptableAnswers) =>
      _$this._acceptableAnswers = acceptableAnswers;

  ListBuilder<String>? _criticalSafetyErrors;
  ListBuilder<String> get criticalSafetyErrors =>
      _$this._criticalSafetyErrors ??= ListBuilder<String>();
  set criticalSafetyErrors(ListBuilder<String>? criticalSafetyErrors) =>
      _$this._criticalSafetyErrors = criticalSafetyErrors;

  ScoringResponseBuilder() {
    ScoringResponse._defaults(this);
  }

  ScoringResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _weightDiagnosis = $v.weightDiagnosis;
      _weightDiagnostics = $v.weightDiagnostics;
      _weightTreatment = $v.weightTreatment;
      _weightSafety = $v.weightSafety;
      _acceptableAnswers = $v.acceptableAnswers.toBuilder();
      _criticalSafetyErrors = $v.criticalSafetyErrors.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoringResponse other) {
    _$v = other as _$ScoringResponse;
  }

  @override
  void update(void Function(ScoringResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoringResponse build() => _build();

  _$ScoringResponse _build() {
    _$ScoringResponse _$result;
    try {
      _$result = _$v ??
          _$ScoringResponse._(
            weightDiagnosis: BuiltValueNullFieldError.checkNotNull(
                weightDiagnosis, r'ScoringResponse', 'weightDiagnosis'),
            weightDiagnostics: BuiltValueNullFieldError.checkNotNull(
                weightDiagnostics, r'ScoringResponse', 'weightDiagnostics'),
            weightTreatment: BuiltValueNullFieldError.checkNotNull(
                weightTreatment, r'ScoringResponse', 'weightTreatment'),
            weightSafety: BuiltValueNullFieldError.checkNotNull(
                weightSafety, r'ScoringResponse', 'weightSafety'),
            acceptableAnswers: acceptableAnswers.build(),
            criticalSafetyErrors: criticalSafetyErrors.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'acceptableAnswers';
        acceptableAnswers.build();
        _$failedField = 'criticalSafetyErrors';
        criticalSafetyErrors.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ScoringResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
