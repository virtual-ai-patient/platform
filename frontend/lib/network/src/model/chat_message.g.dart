// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chat_message.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ChatMessage extends ChatMessage {
  @override
  final String role;
  @override
  final String content;
  @override
  final DateTime loggedAt;

  factory _$ChatMessage([void Function(ChatMessageBuilder)? updates]) =>
      (ChatMessageBuilder()..update(updates))._build();

  _$ChatMessage._(
      {required this.role, required this.content, required this.loggedAt})
      : super._();
  @override
  ChatMessage rebuild(void Function(ChatMessageBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ChatMessageBuilder toBuilder() => ChatMessageBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ChatMessage &&
        role == other.role &&
        content == other.content &&
        loggedAt == other.loggedAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, loggedAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ChatMessage')
          ..add('role', role)
          ..add('content', content)
          ..add('loggedAt', loggedAt))
        .toString();
  }
}

class ChatMessageBuilder implements Builder<ChatMessage, ChatMessageBuilder> {
  _$ChatMessage? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _loggedAt;
  DateTime? get loggedAt => _$this._loggedAt;
  set loggedAt(DateTime? loggedAt) => _$this._loggedAt = loggedAt;

  ChatMessageBuilder() {
    ChatMessage._defaults(this);
  }

  ChatMessageBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _content = $v.content;
      _loggedAt = $v.loggedAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ChatMessage other) {
    _$v = other as _$ChatMessage;
  }

  @override
  void update(void Function(ChatMessageBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ChatMessage build() => _build();

  _$ChatMessage _build() {
    final _$result = _$v ??
        _$ChatMessage._(
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'ChatMessage', 'role'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'ChatMessage', 'content'),
          loggedAt: BuiltValueNullFieldError.checkNotNull(
              loggedAt, r'ChatMessage', 'loggedAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
