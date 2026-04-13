// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatResponse extends ChatResponse {
  @override
  final String response;
  @override
  final DateTime loggedAt;

  factory _$ChatResponse([void Function(ChatResponseBuilder)? updates]) =>
      (ChatResponseBuilder()..update(updates))._build();

  _$ChatResponse._({required this.response, required this.loggedAt})
      : super._();
  @override
  ChatResponse rebuild(void Function(ChatResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatResponseBuilder toBuilder() => ChatResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatResponse &&
        response == other.response &&
        loggedAt == other.loggedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, response.hashCode);
    _$hash = $jc(_$hash, loggedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatResponse')
          ..add('response', response)
          ..add('loggedAt', loggedAt))
        .toString();
  }
}

class ChatResponseBuilder
    implements Builder<ChatResponse, ChatResponseBuilder> {
  _$ChatResponse? _$v;

  String? _response;
  String? get response => _$this._response;
  set response(String? response) => _$this._response = response;

  DateTime? _loggedAt;
  DateTime? get loggedAt => _$this._loggedAt;
  set loggedAt(DateTime? loggedAt) => _$this._loggedAt = loggedAt;

  ChatResponseBuilder() {
    ChatResponse._defaults(this);
  }

  ChatResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _response = $v.response;
      _loggedAt = $v.loggedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatResponse other) {
    _$v = other as _$ChatResponse;
  }

  @override
  void update(void Function(ChatResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatResponse build() => _build();

  _$ChatResponse _build() {
    final _$result = _$v ??
        _$ChatResponse._(
          response: BuiltValueNullFieldError.checkNotNull(
              response, r'ChatResponse', 'response'),
          loggedAt: BuiltValueNullFieldError.checkNotNull(
              loggedAt, r'ChatResponse', 'loggedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
