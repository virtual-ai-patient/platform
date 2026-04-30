// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'action_log_entry.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ActionLogEntry extends ActionLogEntry {
  @override
  final String role;
  @override
  final String content;
  @override
  final DateTime createdAt;

  factory _$ActionLogEntry([void Function(ActionLogEntryBuilder)? updates]) =>
      (ActionLogEntryBuilder()..update(updates))._build();

  _$ActionLogEntry._(
      {required this.role, required this.content, required this.createdAt})
      : super._();
  @override
  ActionLogEntry rebuild(void Function(ActionLogEntryBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ActionLogEntryBuilder toBuilder() => ActionLogEntryBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ActionLogEntry &&
        role == other.role &&
        content == other.content &&
        createdAt == other.createdAt;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, role.hashCode);
    _$hash = $jc(_$hash, content.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ActionLogEntry')
          ..add('role', role)
          ..add('content', content)
          ..add('createdAt', createdAt))
        .toString();
  }
}

class ActionLogEntryBuilder
    implements Builder<ActionLogEntry, ActionLogEntryBuilder> {
  _$ActionLogEntry? _$v;

  String? _role;
  String? get role => _$this._role;
  set role(String? role) => _$this._role = role;

  String? _content;
  String? get content => _$this._content;
  set content(String? content) => _$this._content = content;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ActionLogEntryBuilder() {
    ActionLogEntry._defaults(this);
  }

  ActionLogEntryBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _role = $v.role;
      _content = $v.content;
      _createdAt = $v.createdAt;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ActionLogEntry other) {
    _$v = other as _$ActionLogEntry;
  }

  @override
  void update(void Function(ActionLogEntryBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ActionLogEntry build() => _build();

  _$ActionLogEntry _build() {
    final _$result = _$v ??
        _$ActionLogEntry._(
          role: BuiltValueNullFieldError.checkNotNull(
              role, r'ActionLogEntry', 'role'),
          content: BuiltValueNullFieldError.checkNotNull(
              content, r'ActionLogEntry', 'content'),
          createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt, r'ActionLogEntry', 'createdAt'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
