// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_history_points_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KeyHistoryPointsResponse extends KeyHistoryPointsResponse {
  @override
  final BuiltList<String> mustAsk;
  @override
  final BuiltList<String> niceToAsk;
  @override
  final BuiltList<String> redFlags;

  factory _$KeyHistoryPointsResponse(
          [void Function(KeyHistoryPointsResponseBuilder)? updates]) =>
      (KeyHistoryPointsResponseBuilder()..update(updates))._build();

  _$KeyHistoryPointsResponse._(
      {required this.mustAsk, required this.niceToAsk, required this.redFlags})
      : super._();
  @override
  KeyHistoryPointsResponse rebuild(
          void Function(KeyHistoryPointsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyHistoryPointsResponseBuilder toBuilder() =>
      KeyHistoryPointsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyHistoryPointsResponse &&
        mustAsk == other.mustAsk &&
        niceToAsk == other.niceToAsk &&
        redFlags == other.redFlags;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mustAsk.hashCode);
    _$hash = $jc(_$hash, niceToAsk.hashCode);
    _$hash = $jc(_$hash, redFlags.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'KeyHistoryPointsResponse')
          ..add('mustAsk', mustAsk)
          ..add('niceToAsk', niceToAsk)
          ..add('redFlags', redFlags))
        .toString();
  }
}

class KeyHistoryPointsResponseBuilder
    implements
        Builder<KeyHistoryPointsResponse, KeyHistoryPointsResponseBuilder> {
  _$KeyHistoryPointsResponse? _$v;

  ListBuilder<String>? _mustAsk;
  ListBuilder<String> get mustAsk => _$this._mustAsk ??= ListBuilder<String>();
  set mustAsk(ListBuilder<String>? mustAsk) => _$this._mustAsk = mustAsk;

  ListBuilder<String>? _niceToAsk;
  ListBuilder<String> get niceToAsk =>
      _$this._niceToAsk ??= ListBuilder<String>();
  set niceToAsk(ListBuilder<String>? niceToAsk) =>
      _$this._niceToAsk = niceToAsk;

  ListBuilder<String>? _redFlags;
  ListBuilder<String> get redFlags =>
      _$this._redFlags ??= ListBuilder<String>();
  set redFlags(ListBuilder<String>? redFlags) => _$this._redFlags = redFlags;

  KeyHistoryPointsResponseBuilder() {
    KeyHistoryPointsResponse._defaults(this);
  }

  KeyHistoryPointsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mustAsk = $v.mustAsk.toBuilder();
      _niceToAsk = $v.niceToAsk.toBuilder();
      _redFlags = $v.redFlags.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(KeyHistoryPointsResponse other) {
    _$v = other as _$KeyHistoryPointsResponse;
  }

  @override
  void update(void Function(KeyHistoryPointsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KeyHistoryPointsResponse build() => _build();

  _$KeyHistoryPointsResponse _build() {
    _$KeyHistoryPointsResponse _$result;
    try {
      _$result = _$v ??
          _$KeyHistoryPointsResponse._(
            mustAsk: mustAsk.build(),
            niceToAsk: niceToAsk.build(),
            redFlags: redFlags.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mustAsk';
        mustAsk.build();
        _$failedField = 'niceToAsk';
        niceToAsk.build();
        _$failedField = 'redFlags';
        redFlags.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'KeyHistoryPointsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
