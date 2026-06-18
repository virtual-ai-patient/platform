// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'treatment_plan.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TreatmentPlan extends TreatmentPlan {
  @override
  final BuiltList<Medication>? medications;
  @override
  final BuiltList<String>? nonPharmacological;
  @override
  final BuiltList<String>? referrals;
  @override
  final BuiltList<String>? followUp;

  factory _$TreatmentPlan([void Function(TreatmentPlanBuilder)? updates]) =>
      (TreatmentPlanBuilder()..update(updates))._build();

  _$TreatmentPlan._(
      {this.medications,
      this.nonPharmacological,
      this.referrals,
      this.followUp})
      : super._();
  @override
  TreatmentPlan rebuild(void Function(TreatmentPlanBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TreatmentPlanBuilder toBuilder() => TreatmentPlanBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TreatmentPlan &&
        medications == other.medications &&
        nonPharmacological == other.nonPharmacological &&
        referrals == other.referrals &&
        followUp == other.followUp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, medications.hashCode);
    _$hash = $jc(_$hash, nonPharmacological.hashCode);
    _$hash = $jc(_$hash, referrals.hashCode);
    _$hash = $jc(_$hash, followUp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TreatmentPlan')
          ..add('medications', medications)
          ..add('nonPharmacological', nonPharmacological)
          ..add('referrals', referrals)
          ..add('followUp', followUp))
        .toString();
  }
}

class TreatmentPlanBuilder
    implements Builder<TreatmentPlan, TreatmentPlanBuilder> {
  _$TreatmentPlan? _$v;

  ListBuilder<Medication>? _medications;
  ListBuilder<Medication> get medications =>
      _$this._medications ??= ListBuilder<Medication>();
  set medications(ListBuilder<Medication>? medications) =>
      _$this._medications = medications;

  ListBuilder<String>? _nonPharmacological;
  ListBuilder<String> get nonPharmacological =>
      _$this._nonPharmacological ??= ListBuilder<String>();
  set nonPharmacological(ListBuilder<String>? nonPharmacological) =>
      _$this._nonPharmacological = nonPharmacological;

  ListBuilder<String>? _referrals;
  ListBuilder<String> get referrals =>
      _$this._referrals ??= ListBuilder<String>();
  set referrals(ListBuilder<String>? referrals) =>
      _$this._referrals = referrals;

  ListBuilder<String>? _followUp;
  ListBuilder<String> get followUp =>
      _$this._followUp ??= ListBuilder<String>();
  set followUp(ListBuilder<String>? followUp) => _$this._followUp = followUp;

  TreatmentPlanBuilder() {
    TreatmentPlan._defaults(this);
  }

  TreatmentPlanBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _medications = $v.medications?.toBuilder();
      _nonPharmacological = $v.nonPharmacological?.toBuilder();
      _referrals = $v.referrals?.toBuilder();
      _followUp = $v.followUp?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TreatmentPlan other) {
    _$v = other as _$TreatmentPlan;
  }

  @override
  void update(void Function(TreatmentPlanBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TreatmentPlan build() => _build();

  _$TreatmentPlan _build() {
    _$TreatmentPlan _$result;
    try {
      _$result = _$v ??
          _$TreatmentPlan._(
            medications: _medications?.build(),
            nonPharmacological: _nonPharmacological?.build(),
            referrals: _referrals?.build(),
            followUp: _followUp?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'medications';
        _medications?.build();
        _$failedField = 'nonPharmacological';
        _nonPharmacological?.build();
        _$failedField = 'referrals';
        _referrals?.build();
        _$failedField = 'followUp';
        _followUp?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'TreatmentPlan', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
