// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expected_tests_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ExpectedTestsRequest extends ExpectedTestsRequest {
  @override
  final BuiltList<String> mustOrder;
  @override
  final BuiltList<String> optional;
  @override
  final BuiltList<String> shouldNotOrder;

  factory _$ExpectedTestsRequest(
          [void Function(ExpectedTestsRequestBuilder)? updates]) =>
      (ExpectedTestsRequestBuilder()..update(updates))._build();

  _$ExpectedTestsRequest._(
      {required this.mustOrder,
      required this.optional,
      required this.shouldNotOrder})
      : super._();
  @override
  ExpectedTestsRequest rebuild(
          void Function(ExpectedTestsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ExpectedTestsRequestBuilder toBuilder() =>
      ExpectedTestsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ExpectedTestsRequest &&
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
    return (newBuiltValueToStringHelper(r'ExpectedTestsRequest')
          ..add('mustOrder', mustOrder)
          ..add('optional', optional)
          ..add('shouldNotOrder', shouldNotOrder))
        .toString();
  }
}

class ExpectedTestsRequestBuilder
    implements Builder<ExpectedTestsRequest, ExpectedTestsRequestBuilder> {
  _$ExpectedTestsRequest? _$v;

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

  ExpectedTestsRequestBuilder() {
    ExpectedTestsRequest._defaults(this);
  }

  ExpectedTestsRequestBuilder get _$this {
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
  void replace(ExpectedTestsRequest other) {
    _$v = other as _$ExpectedTestsRequest;
  }

  @override
  void update(void Function(ExpectedTestsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ExpectedTestsRequest build() => _build();

  _$ExpectedTestsRequest _build() {
    _$ExpectedTestsRequest _$result;
    try {
      _$result = _$v ??
          _$ExpectedTestsRequest._(
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
            r'ExpectedTestsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
