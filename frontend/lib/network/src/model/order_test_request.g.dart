// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_test_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$OrderTestRequest extends OrderTestRequest {
  @override
  final String testId;

  factory _$OrderTestRequest(
          [void Function(OrderTestRequestBuilder)? updates]) =>
      (OrderTestRequestBuilder()..update(updates))._build();

  _$OrderTestRequest._({required this.testId}) : super._();
  @override
  OrderTestRequest rebuild(void Function(OrderTestRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  OrderTestRequestBuilder toBuilder() =>
      OrderTestRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is OrderTestRequest && testId == other.testId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, testId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'OrderTestRequest')
          ..add('testId', testId))
        .toString();
  }
}

class OrderTestRequestBuilder
    implements Builder<OrderTestRequest, OrderTestRequestBuilder> {
  _$OrderTestRequest? _$v;

  String? _testId;
  String? get testId => _$this._testId;
  set testId(String? testId) => _$this._testId = testId;

  OrderTestRequestBuilder() {
    OrderTestRequest._defaults(this);
  }

  OrderTestRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _testId = $v.testId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(OrderTestRequest other) {
    _$v = other as _$OrderTestRequest;
  }

  @override
  void update(void Function(OrderTestRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  OrderTestRequest build() => _build();

  _$OrderTestRequest _build() {
    final _$result = _$v ??
        _$OrderTestRequest._(
          testId: BuiltValueNullFieldError.checkNotNull(
              testId, r'OrderTestRequest', 'testId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
