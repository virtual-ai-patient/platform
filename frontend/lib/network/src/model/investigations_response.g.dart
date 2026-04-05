// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigations_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvestigationsResponse extends InvestigationsResponse {
  @override
  final BuiltList<String> catalogHints;
  @override
  final ExpectedTestsResponse expected;
  @override
  final BuiltList<InvestigationResultResponse> results;

  factory _$InvestigationsResponse(
          [void Function(InvestigationsResponseBuilder)? updates]) =>
      (InvestigationsResponseBuilder()..update(updates))._build();

  _$InvestigationsResponse._(
      {required this.catalogHints,
      required this.expected,
      required this.results})
      : super._();
  @override
  InvestigationsResponse rebuild(
          void Function(InvestigationsResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestigationsResponseBuilder toBuilder() =>
      InvestigationsResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestigationsResponse &&
        catalogHints == other.catalogHints &&
        expected == other.expected &&
        results == other.results;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, catalogHints.hashCode);
    _$hash = $jc(_$hash, expected.hashCode);
    _$hash = $jc(_$hash, results.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvestigationsResponse')
          ..add('catalogHints', catalogHints)
          ..add('expected', expected)
          ..add('results', results))
        .toString();
  }
}

class InvestigationsResponseBuilder
    implements Builder<InvestigationsResponse, InvestigationsResponseBuilder> {
  _$InvestigationsResponse? _$v;

  ListBuilder<String>? _catalogHints;
  ListBuilder<String> get catalogHints =>
      _$this._catalogHints ??= ListBuilder<String>();
  set catalogHints(ListBuilder<String>? catalogHints) =>
      _$this._catalogHints = catalogHints;

  ExpectedTestsResponseBuilder? _expected;
  ExpectedTestsResponseBuilder get expected =>
      _$this._expected ??= ExpectedTestsResponseBuilder();
  set expected(ExpectedTestsResponseBuilder? expected) =>
      _$this._expected = expected;

  ListBuilder<InvestigationResultResponse>? _results;
  ListBuilder<InvestigationResultResponse> get results =>
      _$this._results ??= ListBuilder<InvestigationResultResponse>();
  set results(ListBuilder<InvestigationResultResponse>? results) =>
      _$this._results = results;

  InvestigationsResponseBuilder() {
    InvestigationsResponse._defaults(this);
  }

  InvestigationsResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _catalogHints = $v.catalogHints.toBuilder();
      _expected = $v.expected.toBuilder();
      _results = $v.results.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestigationsResponse other) {
    _$v = other as _$InvestigationsResponse;
  }

  @override
  void update(void Function(InvestigationsResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvestigationsResponse build() => _build();

  _$InvestigationsResponse _build() {
    _$InvestigationsResponse _$result;
    try {
      _$result = _$v ??
          _$InvestigationsResponse._(
            catalogHints: catalogHints.build(),
            expected: expected.build(),
            results: results.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'catalogHints';
        catalogHints.build();
        _$failedField = 'expected';
        expected.build();
        _$failedField = 'results';
        results.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'InvestigationsResponse', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
