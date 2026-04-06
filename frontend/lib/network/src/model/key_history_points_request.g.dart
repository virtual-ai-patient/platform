// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'key_history_points_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$KeyHistoryPointsRequest extends KeyHistoryPointsRequest {
  @override
  final BuiltList<String> mustAsk;
  @override
  final BuiltList<String> niceToAsk;
  @override
  final BuiltList<String> redFlags;

  factory _$KeyHistoryPointsRequest(
          [void Function(KeyHistoryPointsRequestBuilder)? updates]) =>
      (KeyHistoryPointsRequestBuilder()..update(updates))._build();

  _$KeyHistoryPointsRequest._(
      {required this.mustAsk, required this.niceToAsk, required this.redFlags})
      : super._();
  @override
  KeyHistoryPointsRequest rebuild(
          void Function(KeyHistoryPointsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  KeyHistoryPointsRequestBuilder toBuilder() =>
      KeyHistoryPointsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is KeyHistoryPointsRequest &&
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
    return (newBuiltValueToStringHelper(r'KeyHistoryPointsRequest')
          ..add('mustAsk', mustAsk)
          ..add('niceToAsk', niceToAsk)
          ..add('redFlags', redFlags))
        .toString();
  }
}

class KeyHistoryPointsRequestBuilder
    implements
        Builder<KeyHistoryPointsRequest, KeyHistoryPointsRequestBuilder> {
  _$KeyHistoryPointsRequest? _$v;

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

  KeyHistoryPointsRequestBuilder() {
    KeyHistoryPointsRequest._defaults(this);
  }

  KeyHistoryPointsRequestBuilder get _$this {
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
  void replace(KeyHistoryPointsRequest other) {
    _$v = other as _$KeyHistoryPointsRequest;
  }

  @override
  void update(void Function(KeyHistoryPointsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  KeyHistoryPointsRequest build() => _build();

  _$KeyHistoryPointsRequest _build() {
    _$KeyHistoryPointsRequest _$result;
    try {
      _$result = _$v ??
          _$KeyHistoryPointsRequest._(
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
            r'KeyHistoryPointsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
