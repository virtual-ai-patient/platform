// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'active_session_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActiveSessionItem extends ActiveSessionItem {
  @override
  final String sessionId;
  @override
  final String caseId;
  @override
  final String caseTitle;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastActivityAt;
  @override
  final ProgressSummary progressSummary;

  factory _$ActiveSessionItem(
          [void Function(ActiveSessionItemBuilder)? updates]) =>
      (ActiveSessionItemBuilder()..update(updates))._build();

  _$ActiveSessionItem._(
      {required this.sessionId,
      required this.caseId,
      required this.caseTitle,
      required this.createdAt,
      required this.lastActivityAt,
      required this.progressSummary})
      : super._();
  @override
  ActiveSessionItem rebuild(void Function(ActiveSessionItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActiveSessionItemBuilder toBuilder() =>
      ActiveSessionItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActiveSessionItem &&
        sessionId == other.sessionId &&
        caseId == other.caseId &&
        caseTitle == other.caseTitle &&
        createdAt == other.createdAt &&
        lastActivityAt == other.lastActivityAt &&
        progressSummary == other.progressSummary;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, caseTitle.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastActivityAt.hashCode);
    _$hash = $jc(_$hash, progressSummary.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActiveSessionItem')
          ..add('sessionId', sessionId)
          ..add('caseId', caseId)
          ..add('caseTitle', caseTitle)
          ..add('createdAt', createdAt)
          ..add('lastActivityAt', lastActivityAt)
          ..add('progressSummary', progressSummary))
        .toString();
  }
}

class ActiveSessionItemBuilder
    implements Builder<ActiveSessionItem, ActiveSessionItemBuilder> {
  _$ActiveSessionItem? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _caseTitle;
  String? get caseTitle => _$this._caseTitle;
  set caseTitle(String? caseTitle) => _$this._caseTitle = caseTitle;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastActivityAt;
  DateTime? get lastActivityAt => _$this._lastActivityAt;
  set lastActivityAt(DateTime? lastActivityAt) =>
      _$this._lastActivityAt = lastActivityAt;

  ProgressSummaryBuilder? _progressSummary;
  ProgressSummaryBuilder get progressSummary =>
      _$this._progressSummary ??= ProgressSummaryBuilder();
  set progressSummary(ProgressSummaryBuilder? progressSummary) =>
      _$this._progressSummary = progressSummary;

  ActiveSessionItemBuilder() {
    ActiveSessionItem._defaults(this);
  }

  ActiveSessionItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _caseId = $v.caseId;
      _caseTitle = $v.caseTitle;
      _createdAt = $v.createdAt;
      _lastActivityAt = $v.lastActivityAt;
      _progressSummary = $v.progressSummary.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActiveSessionItem other) {
    _$v = other as _$ActiveSessionItem;
  }

  @override
  void update(void Function(ActiveSessionItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActiveSessionItem build() => _build();

  _$ActiveSessionItem _build() {
    _$ActiveSessionItem _$result;
    try {
      _$result = _$v ??
          _$ActiveSessionItem._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
                sessionId, r'ActiveSessionItem', 'sessionId'),
            caseId: BuiltValueNullFieldError.checkNotNull(
                caseId, r'ActiveSessionItem', 'caseId'),
            caseTitle: BuiltValueNullFieldError.checkNotNull(
                caseTitle, r'ActiveSessionItem', 'caseTitle'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'ActiveSessionItem', 'createdAt'),
            lastActivityAt: BuiltValueNullFieldError.checkNotNull(
                lastActivityAt, r'ActiveSessionItem', 'lastActivityAt'),
            progressSummary: progressSummary.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'progressSummary';
        progressSummary.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ActiveSessionItem', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
