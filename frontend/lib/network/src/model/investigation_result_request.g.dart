// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'investigation_result_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

const InvestigationResultRequestResultTypeEnum
    _$investigationResultRequestResultTypeEnum_textReport =
    const InvestigationResultRequestResultTypeEnum._('textReport');
const InvestigationResultRequestResultTypeEnum
    _$investigationResultRequestResultTypeEnum_labValue =
    const InvestigationResultRequestResultTypeEnum._('labValue');

InvestigationResultRequestResultTypeEnum
    _$investigationResultRequestResultTypeEnumValueOf(String name) {
  switch (name) {
    case 'textReport':
      return _$investigationResultRequestResultTypeEnum_textReport;
    case 'labValue':
      return _$investigationResultRequestResultTypeEnum_labValue;
    default:
      throw ArgumentError(name);
  }
}

final BuiltSet<InvestigationResultRequestResultTypeEnum>
    _$investigationResultRequestResultTypeEnumValues = BuiltSet<
        InvestigationResultRequestResultTypeEnum>(const <InvestigationResultRequestResultTypeEnum>[
  _$investigationResultRequestResultTypeEnum_textReport,
  _$investigationResultRequestResultTypeEnum_labValue,
]);

Serializer<InvestigationResultRequestResultTypeEnum>
    _$investigationResultRequestResultTypeEnumSerializer =
    _$InvestigationResultRequestResultTypeEnumSerializer();

class _$InvestigationResultRequestResultTypeEnumSerializer
    implements PrimitiveSerializer<InvestigationResultRequestResultTypeEnum> {
  static const Map<String, Object> _toWire = const <String, Object>{
    'textReport': 'text_report',
    'labValue': 'lab_value',
  };
  static const Map<Object, String> _fromWire = const <Object, String>{
    'text_report': 'textReport',
    'lab_value': 'labValue',
  };

  @override
  final Iterable<Type> types = const <Type>[
    InvestigationResultRequestResultTypeEnum
  ];
  @override
  final String wireName = 'InvestigationResultRequestResultTypeEnum';

  @override
  Object serialize(Serializers serializers,
          InvestigationResultRequestResultTypeEnum object,
          {FullType specifiedType = FullType.unspecified}) =>
      _toWire[object.name] ?? object.name;

  @override
  InvestigationResultRequestResultTypeEnum deserialize(
          Serializers serializers, Object serialized,
          {FullType specifiedType = FullType.unspecified}) =>
      InvestigationResultRequestResultTypeEnum.valueOf(
          _fromWire[serialized] ?? (serialized is String ? serialized : ''));
}

class _$InvestigationResultRequest extends InvestigationResultRequest {
  @override
  final String testName;
  @override
  final InvestigationResultRequestResultTypeEnum resultType;
  @override
  final String value;
  @override
  final String? unit;
  @override
  final String? referenceRange;

  factory _$InvestigationResultRequest(
          [void Function(InvestigationResultRequestBuilder)? updates]) =>
      (InvestigationResultRequestBuilder()..update(updates))._build();

  _$InvestigationResultRequest._(
      {required this.testName,
      required this.resultType,
      required this.value,
      this.unit,
      this.referenceRange})
      : super._();
  @override
  InvestigationResultRequest rebuild(
          void Function(InvestigationResultRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  InvestigationResultRequestBuilder toBuilder() =>
      InvestigationResultRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is InvestigationResultRequest &&
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
    return (newBuiltValueToStringHelper(r'InvestigationResultRequest')
          ..add('testName', testName)
          ..add('resultType', resultType)
          ..add('value', value)
          ..add('unit', unit)
          ..add('referenceRange', referenceRange))
        .toString();
  }
}

class InvestigationResultRequestBuilder
    implements
        Builder<InvestigationResultRequest, InvestigationResultRequestBuilder> {
  _$InvestigationResultRequest? _$v;

  String? _testName;
  String? get testName => _$this._testName;
  set testName(String? testName) => _$this._testName = testName;

  InvestigationResultRequestResultTypeEnum? _resultType;
  InvestigationResultRequestResultTypeEnum? get resultType =>
      _$this._resultType;
  set resultType(InvestigationResultRequestResultTypeEnum? resultType) =>
      _$this._resultType = resultType;

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

  InvestigationResultRequestBuilder() {
    InvestigationResultRequest._defaults(this);
  }

  InvestigationResultRequestBuilder get _$this {
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
  void replace(InvestigationResultRequest other) {
    _$v = other as _$InvestigationResultRequest;
  }

  @override
  void update(void Function(InvestigationResultRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  InvestigationResultRequest build() => _build();

  _$InvestigationResultRequest _build() {
    final _$result = _$v ??
        _$InvestigationResultRequest._(
          testName: BuiltValueNullFieldError.checkNotNull(
              testName, r'InvestigationResultRequest', 'testName'),
          resultType: BuiltValueNullFieldError.checkNotNull(
              resultType, r'InvestigationResultRequest', 'resultType'),
          value: BuiltValueNullFieldError.checkNotNull(
              value, r'InvestigationResultRequest', 'value'),
          unit: unit,
          referenceRange: referenceRange,
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
