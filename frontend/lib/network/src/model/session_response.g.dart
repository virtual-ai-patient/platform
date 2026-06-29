// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionResponse extends SessionResponse {
  @override
  final String sessionId;
  @override
  final String caseId;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastActivityAt;

  factory _$SessionResponse([void Function(SessionResponseBuilder)? updates]) =>
      (SessionResponseBuilder()..update(updates))._build();

  _$SessionResponse._({
    required this.sessionId,
    required this.caseId,
    required this.status,
    required this.createdAt,
    required this.lastActivityAt,
  }) : super._();
  @override
  SessionResponse rebuild(void Function(SessionResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionResponseBuilder toBuilder() => SessionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionResponse &&
        sessionId == other.sessionId &&
        caseId == other.caseId &&
        status == other.status &&
        createdAt == other.createdAt &&
        lastActivityAt == other.lastActivityAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastActivityAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionResponse')
          ..add('sessionId', sessionId)
          ..add('caseId', caseId)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('lastActivityAt', lastActivityAt))
        .toString();
  }
}

class SessionResponseBuilder
    implements Builder<SessionResponse, SessionResponseBuilder> {
  _$SessionResponse? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  DateTime? _lastActivityAt;
  DateTime? get lastActivityAt => _$this._lastActivityAt;
  set lastActivityAt(DateTime? lastActivityAt) =>
      _$this._lastActivityAt = lastActivityAt;

  SessionResponseBuilder() {
    SessionResponse._defaults(this);
  }

  SessionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _caseId = $v.caseId;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _lastActivityAt = $v.lastActivityAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionResponse other) {
    _$v = other as _$SessionResponse;
  }

  @override
  void update(void Function(SessionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionResponse build() => _build();

  _$SessionResponse _build() {
    final _$result =
        _$v ??
        _$SessionResponse._(
          sessionId: BuiltValueNullFieldError.checkNotNull(
            sessionId,
            r'SessionResponse',
            'sessionId',
          ),
          caseId: BuiltValueNullFieldError.checkNotNull(
            caseId,
            r'SessionResponse',
            'caseId',
          ),
          status: BuiltValueNullFieldError.checkNotNull(
            status,
            r'SessionResponse',
            'status',
          ),
          createdAt: BuiltValueNullFieldError.checkNotNull(
            createdAt,
            r'SessionResponse',
            'createdAt',
          ),
          lastActivityAt: BuiltValueNullFieldError.checkNotNull(
            lastActivityAt,
            r'SessionResponse',
            'lastActivityAt',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
