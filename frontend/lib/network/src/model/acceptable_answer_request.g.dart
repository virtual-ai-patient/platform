// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'acceptable_answer_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AcceptableAnswerRequest extends AcceptableAnswerRequest {
  @override
  final String field;
  @override
  final String answer;

  factory _$AcceptableAnswerRequest(
          [void Function(AcceptableAnswerRequestBuilder)? updates]) =>
      (AcceptableAnswerRequestBuilder()..update(updates))._build();

  _$AcceptableAnswerRequest._({required this.field, required this.answer})
      : super._();
  @override
  AcceptableAnswerRequest rebuild(
          void Function(AcceptableAnswerRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AcceptableAnswerRequestBuilder toBuilder() =>
      AcceptableAnswerRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AcceptableAnswerRequest &&
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
    return (newBuiltValueToStringHelper(r'AcceptableAnswerRequest')
          ..add('field', field)
          ..add('answer', answer))
        .toString();
  }
}

class AcceptableAnswerRequestBuilder
    implements
        Builder<AcceptableAnswerRequest, AcceptableAnswerRequestBuilder> {
  _$AcceptableAnswerRequest? _$v;

  String? _field;
  String? get field => _$this._field;
  set field(String? field) => _$this._field = field;

  String? _answer;
  String? get answer => _$this._answer;
  set answer(String? answer) => _$this._answer = answer;

  AcceptableAnswerRequestBuilder() {
    AcceptableAnswerRequest._defaults(this);
  }

  AcceptableAnswerRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _field = $v.field;
      _answer = $v.answer;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AcceptableAnswerRequest other) {
    _$v = other as _$AcceptableAnswerRequest;
  }

  @override
  void update(void Function(AcceptableAnswerRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AcceptableAnswerRequest build() => _build();

  _$AcceptableAnswerRequest _build() {
    final _$result = _$v ??
        _$AcceptableAnswerRequest._(
          field: BuiltValueNullFieldError.checkNotNull(
              field, r'AcceptableAnswerRequest', 'field'),
          answer: BuiltValueNullFieldError.checkNotNull(
              answer, r'AcceptableAnswerRequest', 'answer'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
