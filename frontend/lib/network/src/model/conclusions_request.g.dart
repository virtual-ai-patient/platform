// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conclusions_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConclusionsRequest extends ConclusionsRequest {
  @override
  final BuiltList<DifferentialDiagnosisItem>? differentialDiagnoses;
  @override
  final String? finalDiagnosis;
  @override
  final TreatmentPlan? treatmentPlan;

  factory _$ConclusionsRequest(
          [void Function(ConclusionsRequestBuilder)? updates]) =>
      (ConclusionsRequestBuilder()..update(updates))._build();

  _$ConclusionsRequest._(
      {this.differentialDiagnoses, this.finalDiagnosis, this.treatmentPlan})
      : super._();
  @override
  ConclusionsRequest rebuild(
          void Function(ConclusionsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConclusionsRequestBuilder toBuilder() =>
      ConclusionsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConclusionsRequest &&
        differentialDiagnoses == other.differentialDiagnoses &&
        finalDiagnosis == other.finalDiagnosis &&
        treatmentPlan == other.treatmentPlan;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, differentialDiagnoses.hashCode);
    _$hash = $jc(_$hash, finalDiagnosis.hashCode);
    _$hash = $jc(_$hash, treatmentPlan.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConclusionsRequest')
          ..add('differentialDiagnoses', differentialDiagnoses)
          ..add('finalDiagnosis', finalDiagnosis)
          ..add('treatmentPlan', treatmentPlan))
        .toString();
  }
}

class ConclusionsRequestBuilder
    implements Builder<ConclusionsRequest, ConclusionsRequestBuilder> {
  _$ConclusionsRequest? _$v;

  ListBuilder<DifferentialDiagnosisItem>? _differentialDiagnoses;
  ListBuilder<DifferentialDiagnosisItem> get differentialDiagnoses =>
      _$this._differentialDiagnoses ??=
          ListBuilder<DifferentialDiagnosisItem>();
  set differentialDiagnoses(
          ListBuilder<DifferentialDiagnosisItem>? differentialDiagnoses) =>
      _$this._differentialDiagnoses = differentialDiagnoses;

  String? _finalDiagnosis;
  String? get finalDiagnosis => _$this._finalDiagnosis;
  set finalDiagnosis(String? finalDiagnosis) =>
      _$this._finalDiagnosis = finalDiagnosis;

  TreatmentPlanBuilder? _treatmentPlan;
  TreatmentPlanBuilder get treatmentPlan =>
      _$this._treatmentPlan ??= TreatmentPlanBuilder();
  set treatmentPlan(TreatmentPlanBuilder? treatmentPlan) =>
      _$this._treatmentPlan = treatmentPlan;

  ConclusionsRequestBuilder() {
    ConclusionsRequest._defaults(this);
  }

  ConclusionsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _differentialDiagnoses = $v.differentialDiagnoses?.toBuilder();
      _finalDiagnosis = $v.finalDiagnosis;
      _treatmentPlan = $v.treatmentPlan?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConclusionsRequest other) {
    _$v = other as _$ConclusionsRequest;
  }

  @override
  void update(void Function(ConclusionsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConclusionsRequest build() => _build();

  _$ConclusionsRequest _build() {
    _$ConclusionsRequest _$result;
    try {
      _$result = _$v ??
          _$ConclusionsRequest._(
            differentialDiagnoses: _differentialDiagnoses?.build(),
            finalDiagnosis: finalDiagnosis,
            treatmentPlan: _treatmentPlan?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'differentialDiagnoses';
        _differentialDiagnoses?.build();

        _$failedField = 'treatmentPlan';
        _treatmentPlan?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ConclusionsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
