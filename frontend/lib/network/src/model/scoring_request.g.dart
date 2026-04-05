// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'scoring_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ScoringRequest extends ScoringRequest {
  @override
  final num weightDiagnosis;
  @override
  final num weightDiagnostics;
  @override
  final num weightTreatment;
  @override
  final num weightSafety;
  @override
  final BuiltList<AcceptableAnswerRequest>? acceptableAnswers;
  @override
  final BuiltList<String>? criticalSafetyErrors;

  factory _$ScoringRequest([void Function(ScoringRequestBuilder)? updates]) =>
      (ScoringRequestBuilder()..update(updates))._build();

  _$ScoringRequest._(
      {required this.weightDiagnosis,
      required this.weightDiagnostics,
      required this.weightTreatment,
      required this.weightSafety,
      this.acceptableAnswers,
      this.criticalSafetyErrors})
      : super._();
  @override
  ScoringRequest rebuild(void Function(ScoringRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ScoringRequestBuilder toBuilder() => ScoringRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ScoringRequest &&
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
    return (newBuiltValueToStringHelper(r'ScoringRequest')
          ..add('weightDiagnosis', weightDiagnosis)
          ..add('weightDiagnostics', weightDiagnostics)
          ..add('weightTreatment', weightTreatment)
          ..add('weightSafety', weightSafety)
          ..add('acceptableAnswers', acceptableAnswers)
          ..add('criticalSafetyErrors', criticalSafetyErrors))
        .toString();
  }
}

class ScoringRequestBuilder
    implements Builder<ScoringRequest, ScoringRequestBuilder> {
  _$ScoringRequest? _$v;

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

  ListBuilder<AcceptableAnswerRequest>? _acceptableAnswers;
  ListBuilder<AcceptableAnswerRequest> get acceptableAnswers =>
      _$this._acceptableAnswers ??= ListBuilder<AcceptableAnswerRequest>();
  set acceptableAnswers(
          ListBuilder<AcceptableAnswerRequest>? acceptableAnswers) =>
      _$this._acceptableAnswers = acceptableAnswers;

  ListBuilder<String>? _criticalSafetyErrors;
  ListBuilder<String> get criticalSafetyErrors =>
      _$this._criticalSafetyErrors ??= ListBuilder<String>();
  set criticalSafetyErrors(ListBuilder<String>? criticalSafetyErrors) =>
      _$this._criticalSafetyErrors = criticalSafetyErrors;

  ScoringRequestBuilder() {
    ScoringRequest._defaults(this);
  }

  ScoringRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _weightDiagnosis = $v.weightDiagnosis;
      _weightDiagnostics = $v.weightDiagnostics;
      _weightTreatment = $v.weightTreatment;
      _weightSafety = $v.weightSafety;
      _acceptableAnswers = $v.acceptableAnswers?.toBuilder();
      _criticalSafetyErrors = $v.criticalSafetyErrors?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ScoringRequest other) {
    _$v = other as _$ScoringRequest;
  }

  @override
  void update(void Function(ScoringRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ScoringRequest build() => _build();

  _$ScoringRequest _build() {
    _$ScoringRequest _$result;
    try {
      _$result = _$v ??
          _$ScoringRequest._(
            weightDiagnosis: BuiltValueNullFieldError.checkNotNull(
                weightDiagnosis, r'ScoringRequest', 'weightDiagnosis'),
            weightDiagnostics: BuiltValueNullFieldError.checkNotNull(
                weightDiagnostics, r'ScoringRequest', 'weightDiagnostics'),
            weightTreatment: BuiltValueNullFieldError.checkNotNull(
                weightTreatment, r'ScoringRequest', 'weightTreatment'),
            weightSafety: BuiltValueNullFieldError.checkNotNull(
                weightSafety, r'ScoringRequest', 'weightSafety'),
            acceptableAnswers: _acceptableAnswers?.build(),
            criticalSafetyErrors: _criticalSafetyErrors?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'acceptableAnswers';
        _acceptableAnswers?.build();
        _$failedField = 'criticalSafetyErrors';
        _criticalSafetyErrors?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ScoringRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
