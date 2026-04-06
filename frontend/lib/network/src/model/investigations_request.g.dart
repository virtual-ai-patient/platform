// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigations_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvestigationsRequest extends InvestigationsRequest {
  @override
  final BuiltList<String>? catalogHints;
  @override
  final ExpectedTestsRequest expected;
  @override
  final BuiltList<InvestigationResultRequest>? results;

  factory _$InvestigationsRequest(
          [void Function(InvestigationsRequestBuilder)? updates]) =>
      (InvestigationsRequestBuilder()..update(updates))._build();

  _$InvestigationsRequest._(
      {this.catalogHints, required this.expected, this.results})
      : super._();
  @override
  InvestigationsRequest rebuild(
          void Function(InvestigationsRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestigationsRequestBuilder toBuilder() =>
      InvestigationsRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestigationsRequest &&
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
    return (newBuiltValueToStringHelper(r'InvestigationsRequest')
          ..add('catalogHints', catalogHints)
          ..add('expected', expected)
          ..add('results', results))
        .toString();
  }
}

class InvestigationsRequestBuilder
    implements Builder<InvestigationsRequest, InvestigationsRequestBuilder> {
  _$InvestigationsRequest? _$v;

  ListBuilder<String>? _catalogHints;
  ListBuilder<String> get catalogHints =>
      _$this._catalogHints ??= ListBuilder<String>();
  set catalogHints(ListBuilder<String>? catalogHints) =>
      _$this._catalogHints = catalogHints;

  ExpectedTestsRequestBuilder? _expected;
  ExpectedTestsRequestBuilder get expected =>
      _$this._expected ??= ExpectedTestsRequestBuilder();
  set expected(ExpectedTestsRequestBuilder? expected) =>
      _$this._expected = expected;

  ListBuilder<InvestigationResultRequest>? _results;
  ListBuilder<InvestigationResultRequest> get results =>
      _$this._results ??= ListBuilder<InvestigationResultRequest>();
  set results(ListBuilder<InvestigationResultRequest>? results) =>
      _$this._results = results;

  InvestigationsRequestBuilder() {
    InvestigationsRequest._defaults(this);
  }

  InvestigationsRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _catalogHints = $v.catalogHints?.toBuilder();
      _expected = $v.expected.toBuilder();
      _results = $v.results?.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestigationsRequest other) {
    _$v = other as _$InvestigationsRequest;
  }

  @override
  void update(void Function(InvestigationsRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvestigationsRequest build() => _build();

  _$InvestigationsRequest _build() {
    _$InvestigationsRequest _$result;
    try {
      _$result = _$v ??
          _$InvestigationsRequest._(
            catalogHints: _catalogHints?.build(),
            expected: expected.build(),
            results: _results?.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'catalogHints';
        _catalogHints?.build();
        _$failedField = 'expected';
        expected.build();
        _$failedField = 'results';
        _results?.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'InvestigationsRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
