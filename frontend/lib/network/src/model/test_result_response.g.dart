// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_result_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$TestResultResponse extends TestResultResponse {
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
  @override
  final bool isNormalDefault;

  factory _$TestResultResponse(
          [void Function(TestResultResponseBuilder)? updates]) =>
      (TestResultResponseBuilder()..update(updates))._build();

  _$TestResultResponse._(
      {required this.testName,
      required this.resultType,
      required this.value,
      this.unit,
      this.referenceRange,
      required this.isNormalDefault})
      : super._();
  @override
  TestResultResponse rebuild(
          void Function(TestResultResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TestResultResponseBuilder toBuilder() =>
      TestResultResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TestResultResponse &&
        testName == other.testName &&
        resultType == other.resultType &&
        value == other.value &&
        unit == other.unit &&
        referenceRange == other.referenceRange &&
        isNormalDefault == other.isNormalDefault;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, testName.hashCode);
    _$hash = $jc(_$hash, resultType.hashCode);
    _$hash = $jc(_$hash, value.hashCode);
    _$hash = $jc(_$hash, unit.hashCode);
    _$hash = $jc(_$hash, referenceRange.hashCode);
    _$hash = $jc(_$hash, isNormalDefault.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'TestResultResponse')
          ..add('testName', testName)
          ..add('resultType', resultType)
          ..add('value', value)
          ..add('unit', unit)
          ..add('referenceRange', referenceRange)
          ..add('isNormalDefault', isNormalDefault))
        .toString();
  }
}

class TestResultResponseBuilder
    implements Builder<TestResultResponse, TestResultResponseBuilder> {
  _$TestResultResponse? _$v;

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

  bool? _isNormalDefault;
  bool? get isNormalDefault => _$this._isNormalDefault;
  set isNormalDefault(bool? isNormalDefault) =>
      _$this._isNormalDefault = isNormalDefault;

  TestResultResponseBuilder() {
    TestResultResponse._defaults(this);
  }

  TestResultResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _testName = $v.testName;
      _resultType = $v.resultType;
      _value = $v.value;
      _unit = $v.unit;
      _referenceRange = $v.referenceRange;
      _isNormalDefault = $v.isNormalDefault;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TestResultResponse other) {
    _$v = other as _$TestResultResponse;
  }

  @override
  void update(void Function(TestResultResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  TestResultResponse build() => _build();

  _$TestResultResponse _build() {
    final _$result = _$v ??
        _$TestResultResponse._(
          testName: BuiltValueNullFieldError.checkNotNull(
              testName, r'TestResultResponse', 'testName'),
          resultType: BuiltValueNullFieldError.checkNotNull(
              resultType, r'TestResultResponse', 'resultType'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'TestResultResponse', 'value'),
          unit: unit,
          referenceRange: referenceRange,
          isNormalDefault: BuiltValueNullFieldError.checkNotNull(
              isNormalDefault, r'TestResultResponse', 'isNormalDefault'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
