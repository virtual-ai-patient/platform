// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_criterion_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommunicationCriterionResponse extends CommunicationCriterionResponse {
  @override
  final String criterion;
  @override
  final int score;
  @override
  final String rationale;
  @override
  final String quote;

  factory _$CommunicationCriterionResponse([
    void Function(CommunicationCriterionResponseBuilder)? updates,
  ]) => (CommunicationCriterionResponseBuilder()..update(updates))._build();

  _$CommunicationCriterionResponse._({
    required this.criterion,
    required this.score,
    required this.rationale,
    required this.quote,
  }) : super._();
  @override
  CommunicationCriterionResponse rebuild(
    void Function(CommunicationCriterionResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CommunicationCriterionResponseBuilder toBuilder() =>
      CommunicationCriterionResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommunicationCriterionResponse &&
        criterion == other.criterion &&
        score == other.score &&
        rationale == other.rationale &&
        quote == other.quote;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, criterion.hashCode);
    _$hash = $jc(_$hash, score.hashCode);
    _$hash = $jc(_$hash, rationale.hashCode);
    _$hash = $jc(_$hash, quote.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommunicationCriterionResponse')
          ..add('criterion', criterion)
          ..add('score', score)
          ..add('rationale', rationale)
          ..add('quote', quote))
        .toString();
  }
}

class CommunicationCriterionResponseBuilder
    implements
        Builder<
          CommunicationCriterionResponse,
          CommunicationCriterionResponseBuilder
        > {
  _$CommunicationCriterionResponse? _$v;

  String? _criterion;
  String? get criterion => _$this._criterion;
  set criterion(String? criterion) => _$this._criterion = criterion;

  int? _score;
  int? get score => _$this._score;
  set score(int? score) => _$this._score = score;

  String? _rationale;
  String? get rationale => _$this._rationale;
  set rationale(String? rationale) => _$this._rationale = rationale;

  String? _quote;
  String? get quote => _$this._quote;
  set quote(String? quote) => _$this._quote = quote;

  CommunicationCriterionResponseBuilder() {
    CommunicationCriterionResponse._defaults(this);
  }

  CommunicationCriterionResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _criterion = $v.criterion;
      _score = $v.score;
      _rationale = $v.rationale;
      _quote = $v.quote;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommunicationCriterionResponse other) {
    _$v = other as _$CommunicationCriterionResponse;
  }

  @override
  void update(void Function(CommunicationCriterionResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommunicationCriterionResponse build() => _build();

  _$CommunicationCriterionResponse _build() {
    final _$result =
        _$v ??
        _$CommunicationCriterionResponse._(
          criterion: BuiltValueNullFieldError.checkNotNull(
            criterion,
            r'CommunicationCriterionResponse',
            'criterion',
          ),
          score: BuiltValueNullFieldError.checkNotNull(
            score,
            r'CommunicationCriterionResponse',
            'score',
          ),
          rationale: BuiltValueNullFieldError.checkNotNull(
            rationale,
            r'CommunicationCriterionResponse',
            'rationale',
          ),
          quote: BuiltValueNullFieldError.checkNotNull(
            quote,
            r'CommunicationCriterionResponse',
            'quote',
          ),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
