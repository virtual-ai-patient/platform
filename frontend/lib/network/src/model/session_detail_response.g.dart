// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_detail_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionDetailResponse extends SessionDetailResponse {
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
  @override
  final BuiltList<ActionLogEntry> actionLog;

  factory _$SessionDetailResponse(
          [void Function(SessionDetailResponseBuilder)? updates]) =>
      (SessionDetailResponseBuilder()..update(updates))._build();

  _$SessionDetailResponse._(
      {required this.sessionId,
      required this.studentUsername,
      required this.caseId,
      required this.caseTitle,
      required this.createdAt,
      required this.actionLog})
      : super._();
  @override
  SessionDetailResponse rebuild(
          void Function(SessionDetailResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionDetailResponseBuilder toBuilder() =>
      SessionDetailResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionDetailResponse &&
        sessionId == other.sessionId &&
        studentUsername == other.studentUsername &&
        caseId == other.caseId &&
        caseTitle == other.caseTitle &&
        createdAt == other.createdAt &&
        actionLog == other.actionLog;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, studentUsername.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, caseTitle.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, actionLog.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionDetailResponse')
          ..add('sessionId', sessionId)
          ..add('studentUsername', studentUsername)
          ..add('caseId', caseId)
          ..add('caseTitle', caseTitle)
          ..add('createdAt', createdAt)
          ..add('actionLog', actionLog))
        .toString();
  }
}

class SessionDetailResponseBuilder
    implements Builder<SessionDetailResponse, SessionDetailResponseBuilder> {
  _$SessionDetailResponse? _$v;

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

  ListBuilder<ActionLogEntry>? _actionLog;
  ListBuilder<ActionLogEntry> get actionLog =>
      _$this._actionLog ??= ListBuilder<ActionLogEntry>();
  set actionLog(ListBuilder<ActionLogEntry>? actionLog) =>
      _$this._actionLog = actionLog;

  SessionDetailResponseBuilder() {
    SessionDetailResponse._defaults(this);
  }

  SessionDetailResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _studentUsername = $v.studentUsername;
      _caseId = $v.caseId;
      _caseTitle = $v.caseTitle;
      _createdAt = $v.createdAt;
      _actionLog = $v.actionLog.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionDetailResponse other) {
    _$v = other as _$SessionDetailResponse;
  }

  @override
  void update(void Function(SessionDetailResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionDetailResponse build() => _build();

  _$SessionDetailResponse _build() {
    _$SessionDetailResponse _$result;
    try {
      _$result = _$v ??
          _$SessionDetailResponse._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
                sessionId, r'SessionDetailResponse', 'sessionId'),
            studentUsername: BuiltValueNullFieldError.checkNotNull(
                studentUsername, r'SessionDetailResponse', 'studentUsername'),
            caseId: BuiltValueNullFieldError.checkNotNull(
                caseId, r'SessionDetailResponse', 'caseId'),
            caseTitle: BuiltValueNullFieldError.checkNotNull(
                caseTitle, r'SessionDetailResponse', 'caseTitle'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SessionDetailResponse', 'createdAt'),
            actionLog: actionLog.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'actionLog';
        actionLog.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SessionDetailResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
