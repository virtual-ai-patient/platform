// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'differential_diagnosis_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DifferentialDiagnosisItem extends DifferentialDiagnosisItem {
  @override
  final int rank;
  @override
  final String condition;

  factory _$DifferentialDiagnosisItem(
          [void Function(DifferentialDiagnosisItemBuilder)? updates]) =>
      (DifferentialDiagnosisItemBuilder()..update(updates))._build();

  _$DifferentialDiagnosisItem._({required this.rank, required this.condition})
      : super._();
  @override
  DifferentialDiagnosisItem rebuild(
          void Function(DifferentialDiagnosisItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DifferentialDiagnosisItemBuilder toBuilder() =>
      DifferentialDiagnosisItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DifferentialDiagnosisItem &&
        rank == other.rank &&
        condition == other.condition;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, rank.hashCode);
    _$hash = $jc(_$hash, condition.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'DifferentialDiagnosisItem')
          ..add('rank', rank)
          ..add('condition', condition))
        .toString();
  }
}

class DifferentialDiagnosisItemBuilder
    implements
        Builder<DifferentialDiagnosisItem, DifferentialDiagnosisItemBuilder> {
  _$DifferentialDiagnosisItem? _$v;

  int? _rank;
  int? get rank => _$this._rank;
  set rank(int? rank) => _$this._rank = rank;

  String? _condition;
  String? get condition => _$this._condition;
  set condition(String? condition) => _$this._condition = condition;

  DifferentialDiagnosisItemBuilder() {
    DifferentialDiagnosisItem._defaults(this);
  }

  DifferentialDiagnosisItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _rank = $v.rank;
      _condition = $v.condition;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DifferentialDiagnosisItem other) {
    _$v = other as _$DifferentialDiagnosisItem;
  }

  @override
  void update(void Function(DifferentialDiagnosisItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DifferentialDiagnosisItem build() => _build();

  _$DifferentialDiagnosisItem _build() {
    final _$result = _$v ??
        _$DifferentialDiagnosisItem._(
          rank: BuiltValueNullFieldError.checkNotNull(
              rank, r'DifferentialDiagnosisItem', 'rank'),
          condition: BuiltValueNullFieldError.checkNotNull(
              condition, r'DifferentialDiagnosisItem', 'condition'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
