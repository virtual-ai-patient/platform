// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conclusions_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ConclusionsResponse extends ConclusionsResponse {
  @override
  final String sessionId;
  @override
  final String status;
  @override
  final BuiltMap<String, JsonObject?>? conclusions;

  factory _$ConclusionsResponse(
          [void Function(ConclusionsResponseBuilder)? updates]) =>
      (ConclusionsResponseBuilder()..update(updates))._build();

  _$ConclusionsResponse._(
      {required this.sessionId, required this.status, this.conclusions})
      : super._();
  @override
  ConclusionsResponse rebuild(
          void Function(ConclusionsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ConclusionsResponseBuilder toBuilder() =>
      ConclusionsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ConclusionsResponse &&
        sessionId == other.sessionId &&
        status == other.status &&
        conclusions == other.conclusions;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, status.hashCode);
    _$hash = $jc(_$hash, conclusions.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ConclusionsResponse')
          ..add('sessionId', sessionId)
          ..add('status', status)
          ..add('conclusions', conclusions))
        .toString();
  }
}

class ConclusionsResponseBuilder
    implements Builder<ConclusionsResponse, ConclusionsResponseBuilder> {
  _$ConclusionsResponse? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _status;
  String? get status => _$this._status;
  set status(String? status) => _$this._status = status;

  MapBuilder<String, JsonObject?>? _conclusions;
  MapBuilder<String, JsonObject?> get conclusions =>
      _$this._conclusions ??= MapBuilder<String, JsonObject?>();
  set conclusions(MapBuilder<String, JsonObject?>? conclusions) =>
      _$this._conclusions = conclusions;

  ConclusionsResponseBuilder() {
    ConclusionsResponse._defaults(this);
  }

  ConclusionsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _status = $v.status;
      _conclusions = $v.conclusions?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ConclusionsResponse other) {
    _$v = other as _$ConclusionsResponse;
  }

  @override
  void update(void Function(ConclusionsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ConclusionsResponse build() => _build();

  _$ConclusionsResponse _build() {
    _$ConclusionsResponse _$result;
    try {
      _$result = _$v ??
          _$ConclusionsResponse._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
                sessionId, r'ConclusionsResponse', 'sessionId'),
            status: BuiltValueNullFieldError.checkNotNull(
                status, r'ConclusionsResponse', 'status'),
            conclusions: _conclusions?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'conclusions';
        _conclusions?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ConclusionsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
