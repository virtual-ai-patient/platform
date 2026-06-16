// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'evaluation_finding_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$EvaluationFindingResponse extends EvaluationFindingResponse {
  @override
  final String category;
  @override
  final String type;
  @override
  final String severity;
  @override
  final String expected;
  @override
  final String actual;
  @override
  final String whyMatters;
  @override
  final String howToCorrect;
  @override
  final num deductionPoints;

  factory _$EvaluationFindingResponse(
          [void Function(EvaluationFindingResponseBuilder)? updates]) =>
      (EvaluationFindingResponseBuilder()..update(updates))._build();

  _$EvaluationFindingResponse._(
      {required this.category,
      required this.type,
      required this.severity,
      required this.expected,
      required this.actual,
      required this.whyMatters,
      required this.howToCorrect,
      required this.deductionPoints})
      : super._();
  @override
  EvaluationFindingResponse rebuild(
          void Function(EvaluationFindingResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  EvaluationFindingResponseBuilder toBuilder() =>
      EvaluationFindingResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is EvaluationFindingResponse &&
        category == other.category &&
        type == other.type &&
        severity == other.severity &&
        expected == other.expected &&
        actual == other.actual &&
        whyMatters == other.whyMatters &&
        howToCorrect == other.howToCorrect &&
        deductionPoints == other.deductionPoints;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jc(_$hash, type.hashCode);
    _$hash = $jc(_$hash, severity.hashCode);
    _$hash = $jc(_$hash, expected.hashCode);
    _$hash = $jc(_$hash, actual.hashCode);
    _$hash = $jc(_$hash, whyMatters.hashCode);
    _$hash = $jc(_$hash, howToCorrect.hashCode);
    _$hash = $jc(_$hash, deductionPoints.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'EvaluationFindingResponse')
          ..add('category', category)
          ..add('type', type)
          ..add('severity', severity)
          ..add('expected', expected)
          ..add('actual', actual)
          ..add('whyMatters', whyMatters)
          ..add('howToCorrect', howToCorrect)
          ..add('deductionPoints', deductionPoints))
        .toString();
  }
}

class EvaluationFindingResponseBuilder
    implements
        Builder<EvaluationFindingResponse, EvaluationFindingResponseBuilder> {
  _$EvaluationFindingResponse? _$v;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  String? _type;
  String? get type => _$this._type;
  set type(String? type) => _$this._type = type;

  String? _severity;
  String? get severity => _$this._severity;
  set severity(String? severity) => _$this._severity = severity;

  String? _expected;
  String? get expected => _$this._expected;
  set expected(String? expected) => _$this._expected = expected;

  String? _actual;
  String? get actual => _$this._actual;
  set actual(String? actual) => _$this._actual = actual;

  String? _whyMatters;
  String? get whyMatters => _$this._whyMatters;
  set whyMatters(String? whyMatters) => _$this._whyMatters = whyMatters;

  String? _howToCorrect;
  String? get howToCorrect => _$this._howToCorrect;
  set howToCorrect(String? howToCorrect) => _$this._howToCorrect = howToCorrect;

  num? _deductionPoints;
  num? get deductionPoints => _$this._deductionPoints;
  set deductionPoints(num? deductionPoints) =>
      _$this._deductionPoints = deductionPoints;

  EvaluationFindingResponseBuilder() {
    EvaluationFindingResponse._defaults(this);
  }

  EvaluationFindingResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _category = $v.category;
      _type = $v.type;
      _severity = $v.severity;
      _expected = $v.expected;
      _actual = $v.actual;
      _whyMatters = $v.whyMatters;
      _howToCorrect = $v.howToCorrect;
      _deductionPoints = $v.deductionPoints;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(EvaluationFindingResponse other) {
    _$v = other as _$EvaluationFindingResponse;
  }

  @override
  void update(void Function(EvaluationFindingResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  EvaluationFindingResponse build() => _build();

  _$EvaluationFindingResponse _build() {
    final _$result = _$v ??
        _$EvaluationFindingResponse._(
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'EvaluationFindingResponse', 'category'),
          type: BuiltValueNullFieldError.checkNotNull(
              type, r'EvaluationFindingResponse', 'type'),
          severity: BuiltValueNullFieldError.checkNotNull(
              severity, r'EvaluationFindingResponse', 'severity'),
          expected: BuiltValueNullFieldError.checkNotNull(
              expected, r'EvaluationFindingResponse', 'expected'),
          actual: BuiltValueNullFieldError.checkNotNull(
              actual, r'EvaluationFindingResponse', 'actual'),
          whyMatters: BuiltValueNullFieldError.checkNotNull(
              whyMatters, r'EvaluationFindingResponse', 'whyMatters'),
          howToCorrect: BuiltValueNullFieldError.checkNotNull(
              howToCorrect, r'EvaluationFindingResponse', 'howToCorrect'),
          deductionPoints: BuiltValueNullFieldError.checkNotNull(
              deductionPoints, r'EvaluationFindingResponse', 'deductionPoints'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
