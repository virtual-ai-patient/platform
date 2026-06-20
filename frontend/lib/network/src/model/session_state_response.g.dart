// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_state_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionStateResponse extends SessionStateResponse {
  @override
  final String sessionId;
  @override
  final String status;
  @override
  final DateTime createdAt;
  @override
  final DateTime lastActivityAt;
  @override
  final BuiltMap<String, JsonObject?> caseSnapshot;
  @override
  final BuiltList<ChatMessage> chatHistory;
  @override
  final int? nextCursor;
  @override
  final BuiltList<String> orderedTests;
  @override
  final BuiltMap<String, JsonObject?>? conclusions;

  factory _$SessionStateResponse(
          [void Function(SessionStateResponseBuilder)? updates]) =>
      (SessionStateResponseBuilder()..update(updates))._build();

  _$SessionStateResponse._(
      {required this.sessionId,
      required this.status,
      required this.createdAt,
      required this.lastActivityAt,
      required this.caseSnapshot,
      required this.chatHistory,
      this.nextCursor,
      required this.orderedTests,
      this.conclusions})
      : super._();
  @override
  SessionStateResponse rebuild(
          void Function(SessionStateResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionStateResponseBuilder toBuilder() =>
      SessionStateResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionStateResponse &&
        sessionId == other.sessionId &&
        status == other.status &&
        createdAt == other.createdAt &&
        lastActivityAt == other.lastActivityAt &&
        caseSnapshot == other.caseSnapshot &&
        chatHistory == other.chatHistory &&
        nextCursor == other.nextCursor &&
        orderedTests == other.orderedTests &&
        conclusions == other.conclusions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, lastActivityAt.hashCode);
    _$hash = $jc(_$hash, caseSnapshot.hashCode);
    _$hash = $jc(_$hash, chatHistory.hashCode);
    _$hash = $jc(_$hash, nextCursor.hashCode);
    _$hash = $jc(_$hash, orderedTests.hashCode);
    _$hash = $jc(_$hash, conclusions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionStateResponse')
          ..add('sessionId', sessionId)
          ..add('status', status)
          ..add('createdAt', createdAt)
          ..add('lastActivityAt', lastActivityAt)
          ..add('caseSnapshot', caseSnapshot)
          ..add('chatHistory', chatHistory)
          ..add('nextCursor', nextCursor)
          ..add('orderedTests', orderedTests)
          ..add('conclusions', conclusions))
        .toString();
  }
}

class SessionStateResponseBuilder
    implements Builder<SessionStateResponse, SessionStateResponseBuilder> {
  _$SessionStateResponse? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

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

  MapBuilder<String, JsonObject?>? _caseSnapshot;
  MapBuilder<String, JsonObject?> get caseSnapshot =>
      _$this._caseSnapshot ??= MapBuilder<String, JsonObject?>();
  set caseSnapshot(MapBuilder<String, JsonObject?>? caseSnapshot) =>
      _$this._caseSnapshot = caseSnapshot;

  ListBuilder<ChatMessage>? _chatHistory;
  ListBuilder<ChatMessage> get chatHistory =>
      _$this._chatHistory ??= ListBuilder<ChatMessage>();
  set chatHistory(ListBuilder<ChatMessage>? chatHistory) =>
      _$this._chatHistory = chatHistory;

  int? _nextCursor;
  int? get nextCursor => _$this._nextCursor;
  set nextCursor(int? nextCursor) => _$this._nextCursor = nextCursor;

  ListBuilder<String>? _orderedTests;
  ListBuilder<String> get orderedTests =>
      _$this._orderedTests ??= ListBuilder<String>();
  set orderedTests(ListBuilder<String>? orderedTests) =>
      _$this._orderedTests = orderedTests;

  MapBuilder<String, JsonObject?>? _conclusions;
  MapBuilder<String, JsonObject?> get conclusions =>
      _$this._conclusions ??= MapBuilder<String, JsonObject?>();
  set conclusions(MapBuilder<String, JsonObject?>? conclusions) =>
      _$this._conclusions = conclusions;

  SessionStateResponseBuilder() {
    SessionStateResponse._defaults(this);
  }

  SessionStateResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _status = $v.status;
      _createdAt = $v.createdAt;
      _lastActivityAt = $v.lastActivityAt;
      _caseSnapshot = $v.caseSnapshot.toBuilder();
      _chatHistory = $v.chatHistory.toBuilder();
      _nextCursor = $v.nextCursor;
      _orderedTests = $v.orderedTests.toBuilder();
      _conclusions = $v.conclusions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionStateResponse other) {
    _$v = other as _$SessionStateResponse;
  }

  @override
  void update(void Function(SessionStateResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionStateResponse build() => _build();

  _$SessionStateResponse _build() {
    _$SessionStateResponse _$result;
    try {
      _$result = _$v ??
          _$SessionStateResponse._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
                sessionId, r'SessionStateResponse', 'sessionId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'SessionStateResponse', 'status'),
            createdAt: BuiltValueNullFieldError.checkNotNull(
                createdAt, r'SessionStateResponse', 'createdAt'),
            lastActivityAt: BuiltValueNullFieldError.checkNotNull(
                lastActivityAt, r'SessionStateResponse', 'lastActivityAt'),
            caseSnapshot: caseSnapshot.build(),
            chatHistory: chatHistory.build(),
            nextCursor: nextCursor,
            orderedTests: orderedTests.build(),
            conclusions: _conclusions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'caseSnapshot';
        caseSnapshot.build();
        _$failedField = 'chatHistory';
        chatHistory.build();

        _$failedField = 'orderedTests';
        orderedTests.build();
        _$failedField = 'conclusions';
        _conclusions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SessionStateResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
