// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatRequest extends ChatRequest {
  @override
  final String message;

  factory _$ChatRequest([void Function(ChatRequestBuilder)? updates]) =>
      (ChatRequestBuilder()..update(updates))._build();

  _$ChatRequest._({required this.message}) : super._();
  @override
  ChatRequest rebuild(void Function(ChatRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatRequestBuilder toBuilder() => ChatRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatRequest && message == other.message;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, message.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatRequest')
          ..add('message', message))
        .toString();
  }
}

class ChatRequestBuilder implements Builder<ChatRequest, ChatRequestBuilder> {
  _$ChatRequest? _$v;

  String? _message;
  String? get message => _$this._message;
  set message(String? message) => _$this._message = message;

  ChatRequestBuilder() {
    ChatRequest._defaults(this);
  }

  ChatRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _message = $v.message;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatRequest other) {
    _$v = other as _$ChatRequest;
  }

  @override
  void update(void Function(ChatRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatRequest build() => _build();

  _$ChatRequest _build() {
    final _$result = _$v ??
        _$ChatRequest._(
          message: BuiltValueNullFieldError.checkNotNull(
              message, r'ChatRequest', 'message'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
