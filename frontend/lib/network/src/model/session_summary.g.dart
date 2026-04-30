// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_summary.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionSummary extends SessionSummary {
  @override
  final String sessionId;
  @override
  final String studentUsername;
  @override
  final String caseId;
  @override
  final String caseTitle;
  @override
  final DateTime createdAt;

  factory _$SessionSummary([void Function(SessionSummaryBuilder)? updates]) =>
      (SessionSummaryBuilder()..update(updates))._build();

  _$SessionSummary._(
      {required this.sessionId,
      required this.studentUsername,
      required this.caseId,
      required this.caseTitle,
      required this.createdAt})
      : super._();
  @override
  SessionSummary rebuild(void Function(SessionSummaryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionSummaryBuilder toBuilder() => SessionSummaryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionSummary &&
        sessionId == other.sessionId &&
        studentUsername == other.studentUsername &&
        caseId == other.caseId &&
        caseTitle == other.caseTitle &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, studentUsername.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, caseTitle.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionSummary')
          ..add('sessionId', sessionId)
          ..add('studentUsername', studentUsername)
          ..add('caseId', caseId)
          ..add('caseTitle', caseTitle)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class SessionSummaryBuilder
    implements Builder<SessionSummary, SessionSummaryBuilder> {
  _$SessionSummary? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _studentUsername;
  String? get studentUsername => _$this._studentUsername;
  set studentUsername(String? studentUsername) =>
      _$this._studentUsername = studentUsername;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _caseTitle;
  String? get caseTitle => _$this._caseTitle;
  set caseTitle(String? caseTitle) => _$this._caseTitle = caseTitle;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  SessionSummaryBuilder() {
    SessionSummary._defaults(this);
  }

  SessionSummaryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _studentUsername = $v.studentUsername;
      _caseId = $v.caseId;
      _caseTitle = $v.caseTitle;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionSummary other) {
    _$v = other as _$SessionSummary;
  }

  @override
  void update(void Function(SessionSummaryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionSummary build() => _build();

  _$SessionSummary _build() {
    final _$result = _$v ??
        _$SessionSummary._(
          sessionId: BuiltValueNullFieldError.checkNotNull(
              sessionId, r'SessionSummary', 'sessionId'),
          studentUsername: BuiltValueNullFieldError.checkNotNull(
              studentUsername, r'SessionSummary', 'studentUsername'),
          caseId: BuiltValueNullFieldError.checkNotNull(
              caseId, r'SessionSummary', 'caseId'),
          caseTitle: BuiltValueNullFieldError.checkNotNull(
              caseTitle, r'SessionSummary', 'caseTitle'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'SessionSummary', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
