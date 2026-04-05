// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigation_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$InvestigationResultResponse extends InvestigationResultResponse {
  @override
  final String testName;
  @override
  final String resultType;
  @override
  final String value;
  @override
  final String? unit;
  @override
  final String? referenceRange;

  factory _$InvestigationResultResponse(
          [void Function(InvestigationResultResponseBuilder)? updates]) =>
      (InvestigationResultResponseBuilder()..update(updates))._build();

  _$InvestigationResultResponse._(
      {required this.testName,
      required this.resultType,
      required this.value,
      this.unit,
      this.referenceRange})
      : super._();
  @override
  InvestigationResultResponse rebuild(
          void Function(InvestigationResultResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestigationResultResponseBuilder toBuilder() =>
      InvestigationResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestigationResultResponse &&
        testName == other.testName &&
        resultType == other.resultType &&
        value == other.value &&
        unit == other.unit &&
        referenceRange == other.referenceRange;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, testName.hashCode);
    _$hash = $jc(_$hash, resultType.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, referenceRange.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'InvestigationResultResponse')
          ..add('testName', testName)
          ..add('resultType', resultType)
          ..add('value', value)
          ..add('unit', unit)
          ..add('referenceRange', referenceRange))
        .toString();
  }
}

class InvestigationResultResponseBuilder
    implements
        Builder<InvestigationResultResponse,
            InvestigationResultResponseBuilder> {
  _$InvestigationResultResponse? _$v;

  String? _testName;
  String? get testName => _$this._testName;
  set testName(String? testName) => _$this._testName = testName;

  String? _resultType;
  String? get resultType => _$this._resultType;
  set resultType(String? resultType) => _$this._resultType = resultType;

  String? _value;
  String? get value => _$this._value;
  set value(String? value) => _$this._value = value;

  String? _unit;
  String? get unit => _$this._unit;
  set unit(String? unit) => _$this._unit = unit;

  String? _referenceRange;
  String? get referenceRange => _$this._referenceRange;
  set referenceRange(String? referenceRange) =>
      _$this._referenceRange = referenceRange;

  InvestigationResultResponseBuilder() {
    InvestigationResultResponse._defaults(this);
  }

  InvestigationResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _testName = $v.testName;
      _resultType = $v.resultType;
      _value = $v.value;
      _unit = $v.unit;
      _referenceRange = $v.referenceRange;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(InvestigationResultResponse other) {
    _$v = other as _$InvestigationResultResponse;
  }

  @override
  void update(void Function(InvestigationResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvestigationResultResponse build() => _build();

  _$InvestigationResultResponse _build() {
    final _$result = _$v ??
        _$InvestigationResultResponse._(
          testName: BuiltValueNullFieldError.checkNotNull(
              testName, r'InvestigationResultResponse', 'testName'),
          resultType: BuiltValueNullFieldError.checkNotNull(
              resultType, r'InvestigationResultResponse', 'resultType'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'InvestigationResultResponse', 'value'),
          unit: unit,
          referenceRange: referenceRange,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
