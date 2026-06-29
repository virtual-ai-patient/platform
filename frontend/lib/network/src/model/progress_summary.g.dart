// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ProgressSummary extends ProgressSummary {
  @override
  final int turnCount;
  @override
  final bool hasConclusions;

  factory _$ProgressSummary([void Function(ProgressSummaryBuilder)? updates]) =>
      (ProgressSummaryBuilder()..update(updates))._build();

  _$ProgressSummary._({required this.turnCount, required this.hasConclusions})
    : super._();
  @override
  ProgressSummary rebuild(void Function(ProgressSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ProgressSummaryBuilder toBuilder() => ProgressSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ProgressSummary &&
        turnCount == other.turnCount &&
        hasConclusions == other.hasConclusions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, turnCount.hashCode);
    _$hash = $jc(_$hash, hasConclusions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ProgressSummary')
          ..add('turnCount', turnCount)
          ..add('hasConclusions', hasConclusions))
        .toString();
  }
}

class ProgressSummaryBuilder
    implements Builder<ProgressSummary, ProgressSummaryBuilder> {
  _$ProgressSummary? _$v;

  int? _turnCount;
  int? get turnCount => _$this._turnCount;
  set turnCount(int? turnCount) => _$this._turnCount = turnCount;

  bool? _hasConclusions;
  bool? get hasConclusions => _$this._hasConclusions;
  set hasConclusions(bool? hasConclusions) =>
      _$this._hasConclusions = hasConclusions;

  ProgressSummaryBuilder() {
    ProgressSummary._defaults(this);
  }

  ProgressSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _turnCount = $v.turnCount;
      _hasConclusions = $v.hasConclusions;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ProgressSummary other) {
    _$v = other as _$ProgressSummary;
  }

  @override
  void update(void Function(ProgressSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ProgressSummary build() => _build();

  _$ProgressSummary _build() {
    final _$result =
        _$v ??
        _$ProgressSummary._(
          turnCount: BuiltValueNullFieldError.checkNotNull(
            turnCount,
            r'ProgressSummary',
            'turnCount',
          ),
          hasConclusions: BuiltValueNullFieldError.checkNotNull(
            hasConclusions,
            r'ProgressSummary',
            'hasConclusions',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
