// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_tests_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExpectedTestsResponse extends ExpectedTestsResponse {
  @override
  final BuiltList<String> mustOrder;
  @override
  final BuiltList<String> optional;
  @override
  final BuiltList<String> shouldNotOrder;

  factory _$ExpectedTestsResponse(
          [void Function(ExpectedTestsResponseBuilder)? updates]) =>
      (ExpectedTestsResponseBuilder()..update(updates))._build();

  _$ExpectedTestsResponse._(
      {required this.mustOrder,
      required this.optional,
      required this.shouldNotOrder})
      : super._();
  @override
  ExpectedTestsResponse rebuild(
          void Function(ExpectedTestsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpectedTestsResponseBuilder toBuilder() =>
      ExpectedTestsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpectedTestsResponse &&
        mustOrder == other.mustOrder &&
        optional == other.optional &&
        shouldNotOrder == other.shouldNotOrder;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, mustOrder.hashCode);
    _$hash = $jc(_$hash, optional.hashCode);
    _$hash = $jc(_$hash, shouldNotOrder.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ExpectedTestsResponse')
          ..add('mustOrder', mustOrder)
          ..add('optional', optional)
          ..add('shouldNotOrder', shouldNotOrder))
        .toString();
  }
}

class ExpectedTestsResponseBuilder
    implements Builder<ExpectedTestsResponse, ExpectedTestsResponseBuilder> {
  _$ExpectedTestsResponse? _$v;

  ListBuilder<String>? _mustOrder;
  ListBuilder<String> get mustOrder =>
      _$this._mustOrder ??= ListBuilder<String>();
  set mustOrder(ListBuilder<String>? mustOrder) =>
      _$this._mustOrder = mustOrder;

  ListBuilder<String>? _optional;
  ListBuilder<String> get optional =>
      _$this._optional ??= ListBuilder<String>();
  set optional(ListBuilder<String>? optional) => _$this._optional = optional;

  ListBuilder<String>? _shouldNotOrder;
  ListBuilder<String> get shouldNotOrder =>
      _$this._shouldNotOrder ??= ListBuilder<String>();
  set shouldNotOrder(ListBuilder<String>? shouldNotOrder) =>
      _$this._shouldNotOrder = shouldNotOrder;

  ExpectedTestsResponseBuilder() {
    ExpectedTestsResponse._defaults(this);
  }

  ExpectedTestsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _mustOrder = $v.mustOrder.toBuilder();
      _optional = $v.optional.toBuilder();
      _shouldNotOrder = $v.shouldNotOrder.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ExpectedTestsResponse other) {
    _$v = other as _$ExpectedTestsResponse;
  }

  @override
  void update(void Function(ExpectedTestsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpectedTestsResponse build() => _build();

  _$ExpectedTestsResponse _build() {
    _$ExpectedTestsResponse _$result;
    try {
      _$result = _$v ??
          _$ExpectedTestsResponse._(
            mustOrder: mustOrder.build(),
            optional: optional.build(),
            shouldNotOrder: shouldNotOrder.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'mustOrder';
        mustOrder.build();
        _$failedField = 'optional';
        optional.build();
        _$failedField = 'shouldNotOrder';
        shouldNotOrder.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ExpectedTestsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
