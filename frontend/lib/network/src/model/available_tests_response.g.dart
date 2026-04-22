// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_tests_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailableTestsResponse extends AvailableTestsResponse {
  @override
  final BuiltList<AvailableTestItem> tests;

  factory _$AvailableTestsResponse(
          [void Function(AvailableTestsResponseBuilder)? updates]) =>
      (AvailableTestsResponseBuilder()..update(updates))._build();

  _$AvailableTestsResponse._({required this.tests}) : super._();
  @override
  AvailableTestsResponse rebuild(
          void Function(AvailableTestsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AvailableTestsResponseBuilder toBuilder() =>
      AvailableTestsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailableTestsResponse && tests == other.tests;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, tests.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AvailableTestsResponse')
          ..add('tests', tests))
        .toString();
  }
}

class AvailableTestsResponseBuilder
    implements Builder<AvailableTestsResponse, AvailableTestsResponseBuilder> {
  _$AvailableTestsResponse? _$v;

  ListBuilder<AvailableTestItem>? _tests;
  ListBuilder<AvailableTestItem> get tests =>
      _$this._tests ??= ListBuilder<AvailableTestItem>();
  set tests(ListBuilder<AvailableTestItem>? tests) => _$this._tests = tests;

  AvailableTestsResponseBuilder() {
    AvailableTestsResponse._defaults(this);
  }

  AvailableTestsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _tests = $v.tests.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailableTestsResponse other) {
    _$v = other as _$AvailableTestsResponse;
  }

  @override
  void update(void Function(AvailableTestsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailableTestsResponse build() => _build();

  _$AvailableTestsResponse _build() {
    _$AvailableTestsResponse _$result;
    try {
      _$result = _$v ??
          _$AvailableTestsResponse._(
            tests: tests.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'tests';
        tests.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'AvailableTestsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
