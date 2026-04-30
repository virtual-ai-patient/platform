// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session_list_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$SessionListResponse extends SessionListResponse {
  @override
  final BuiltList<SessionSummary> sessions;
  @override
  final int total;
  @override
  final int page;
  @override
  final int pageSize;

  factory _$SessionListResponse(
          [void Function(SessionListResponseBuilder)? updates]) =>
      (SessionListResponseBuilder()..update(updates))._build();

  _$SessionListResponse._(
      {required this.sessions,
      required this.total,
      required this.page,
      required this.pageSize})
      : super._();
  @override
  SessionListResponse rebuild(
          void Function(SessionListResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SessionListResponseBuilder toBuilder() =>
      SessionListResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SessionListResponse &&
        sessions == other.sessions &&
        total == other.total &&
        page == other.page &&
        pageSize == other.pageSize;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessions.hashCode);
    _$hash = $jc(_$hash, total.hashCode);
    _$hash = $jc(_$hash, page.hashCode);
    _$hash = $jc(_$hash, pageSize.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'SessionListResponse')
          ..add('sessions', sessions)
          ..add('total', total)
          ..add('page', page)
          ..add('pageSize', pageSize))
        .toString();
  }
}

class SessionListResponseBuilder
    implements Builder<SessionListResponse, SessionListResponseBuilder> {
  _$SessionListResponse? _$v;

  ListBuilder<SessionSummary>? _sessions;
  ListBuilder<SessionSummary> get sessions =>
      _$this._sessions ??= ListBuilder<SessionSummary>();
  set sessions(ListBuilder<SessionSummary>? sessions) =>
      _$this._sessions = sessions;

  int? _total;
  int? get total => _$this._total;
  set total(int? total) => _$this._total = total;

  int? _page;
  int? get page => _$this._page;
  set page(int? page) => _$this._page = page;

  int? _pageSize;
  int? get pageSize => _$this._pageSize;
  set pageSize(int? pageSize) => _$this._pageSize = pageSize;

  SessionListResponseBuilder() {
    SessionListResponse._defaults(this);
  }

  SessionListResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessions = $v.sessions.toBuilder();
      _total = $v.total;
      _page = $v.page;
      _pageSize = $v.pageSize;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SessionListResponse other) {
    _$v = other as _$SessionListResponse;
  }

  @override
  void update(void Function(SessionListResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  SessionListResponse build() => _build();

  _$SessionListResponse _build() {
    _$SessionListResponse _$result;
    try {
      _$result = _$v ??
          _$SessionListResponse._(
            sessions: sessions.build(),
            total: BuiltValueNullFieldError.checkNotNull(
                total, r'SessionListResponse', 'total'),
            page: BuiltValueNullFieldError.checkNotNull(
                page, r'SessionListResponse', 'page'),
            pageSize: BuiltValueNullFieldError.checkNotNull(
                pageSize, r'SessionListResponse', 'pageSize'),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'sessions';
        sessions.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'SessionListResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
