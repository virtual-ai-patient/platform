// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acceptable_answer_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcceptableAnswerResponse extends AcceptableAnswerResponse {
  @override
  final String field;
  @override
  final String answer;

  factory _$AcceptableAnswerResponse(
          [void Function(AcceptableAnswerResponseBuilder)? updates]) =>
      (AcceptableAnswerResponseBuilder()..update(updates))._build();

  _$AcceptableAnswerResponse._({required this.field, required this.answer})
      : super._();
  @override
  AcceptableAnswerResponse rebuild(
          void Function(AcceptableAnswerResponseBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AcceptableAnswerResponseBuilder toBuilder() =>
      AcceptableAnswerResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcceptableAnswerResponse &&
        field == other.field &&
        answer == other.answer;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, field.hashCode);
    _$hash = $jc(_$hash, answer.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AcceptableAnswerResponse')
          ..add('field', field)
          ..add('answer', answer))
        .toString();
  }
}

class AcceptableAnswerResponseBuilder
    implements
        Builder<AcceptableAnswerResponse, AcceptableAnswerResponseBuilder> {
  _$AcceptableAnswerResponse? _$v;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  AcceptableAnswerResponseBuilder() {
    AcceptableAnswerResponse._defaults(this);
  }

  AcceptableAnswerResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _field = $v.field;
      _answer = $v.answer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcceptableAnswerResponse other) {
    _$v = other as _$AcceptableAnswerResponse;
  }

  @override
  void update(void Function(AcceptableAnswerResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcceptableAnswerResponse build() => _build();

  _$AcceptableAnswerResponse _build() {
    final _$result = _$v ??
        _$AcceptableAnswerResponse._(
          field: BuiltValueNullFieldError.checkNotNull(
              field, r'AcceptableAnswerResponse', 'field'),
          answer: BuiltValueNullFieldError.checkNotNull(
              answer, r'AcceptableAnswerResponse', 'answer'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
