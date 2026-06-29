// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'communication_evaluation_response.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$CommunicationEvaluationResponse
    extends CommunicationEvaluationResponse {
  @override
  final String sessionId;
  @override
  final String model;
  @override
  final String promptVersion;
  @override
  final num totalScore;
  @override
  final DateTime createdAt;
  @override
  final BuiltList<CommunicationCriterionResponse> criteria;

  factory _$CommunicationEvaluationResponse([
    void Function(CommunicationEvaluationResponseBuilder)? updates,
  ]) => (CommunicationEvaluationResponseBuilder()..update(updates))._build();

  _$CommunicationEvaluationResponse._({
    required this.sessionId,
    required this.model,
    required this.promptVersion,
    required this.totalScore,
    required this.createdAt,
    required this.criteria,
  }) : super._();
  @override
  CommunicationEvaluationResponse rebuild(
    void Function(CommunicationEvaluationResponseBuilder) updates,
  ) => (toBuilder()..update(updates)).build();

  @override
  CommunicationEvaluationResponseBuilder toBuilder() =>
      CommunicationEvaluationResponseBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is CommunicationEvaluationResponse &&
        sessionId == other.sessionId &&
        model == other.model &&
        promptVersion == other.promptVersion &&
        totalScore == other.totalScore &&
        createdAt == other.createdAt &&
        criteria == other.criteria;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, sessionId.hashCode);
    _$hash = $jc(_$hash, model.hashCode);
    _$hash = $jc(_$hash, promptVersion.hashCode);
    _$hash = $jc(_$hash, totalScore.hashCode);
    _$hash = $jc(_$hash, createdAt.hashCode);
    _$hash = $jc(_$hash, criteria.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'CommunicationEvaluationResponse')
          ..add('sessionId', sessionId)
          ..add('model', model)
          ..add('promptVersion', promptVersion)
          ..add('totalScore', totalScore)
          ..add('createdAt', createdAt)
          ..add('criteria', criteria))
        .toString();
  }
}

class CommunicationEvaluationResponseBuilder
    implements
        Builder<
          CommunicationEvaluationResponse,
          CommunicationEvaluationResponseBuilder
        > {
  _$CommunicationEvaluationResponse? _$v;

  String? _sessionId;
  String? get sessionId => _$this._sessionId;
  set sessionId(String? sessionId) => _$this._sessionId = sessionId;

  String? _model;
  String? get model => _$this._model;
  set model(String? model) => _$this._model = model;

  String? _promptVersion;
  String? get promptVersion => _$this._promptVersion;
  set promptVersion(String? promptVersion) =>
      _$this._promptVersion = promptVersion;

  num? _totalScore;
  num? get totalScore => _$this._totalScore;
  set totalScore(num? totalScore) => _$this._totalScore = totalScore;

  DateTime? _createdAt;
  DateTime? get createdAt => _$this._createdAt;
  set createdAt(DateTime? createdAt) => _$this._createdAt = createdAt;

  ListBuilder<CommunicationCriterionResponse>? _criteria;
  ListBuilder<CommunicationCriterionResponse> get criteria =>
      _$this._criteria ??= ListBuilder<CommunicationCriterionResponse>();
  set criteria(ListBuilder<CommunicationCriterionResponse>? criteria) =>
      _$this._criteria = criteria;

  CommunicationEvaluationResponseBuilder() {
    CommunicationEvaluationResponse._defaults(this);
  }

  CommunicationEvaluationResponseBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _sessionId = $v.sessionId;
      _model = $v.model;
      _promptVersion = $v.promptVersion;
      _totalScore = $v.totalScore;
      _createdAt = $v.createdAt;
      _criteria = $v.criteria.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(CommunicationEvaluationResponse other) {
    _$v = other as _$CommunicationEvaluationResponse;
  }

  @override
  void update(void Function(CommunicationEvaluationResponseBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  CommunicationEvaluationResponse build() => _build();

  _$CommunicationEvaluationResponse _build() {
    _$CommunicationEvaluationResponse _$result;
    try {
      _$result =
          _$v ??
          _$CommunicationEvaluationResponse._(
            sessionId: BuiltValueNullFieldError.checkNotNull(
              sessionId,
              r'CommunicationEvaluationResponse',
              'sessionId',
            ),
            model: BuiltValueNullFieldError.checkNotNull(
              model,
              r'CommunicationEvaluationResponse',
              'model',
            ),
            promptVersion: BuiltValueNullFieldError.checkNotNull(
              promptVersion,
              r'CommunicationEvaluationResponse',
              'promptVersion',
            ),
            totalScore: BuiltValueNullFieldError.checkNotNull(
              totalScore,
              r'CommunicationEvaluationResponse',
              'totalScore',
            ),
            createdAt: BuiltValueNullFieldError.checkNotNull(
              createdAt,
              r'CommunicationEvaluationResponse',
              'createdAt',
            ),
            criteria: criteria.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'criteria';
        criteria.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
          r'CommunicationEvaluationResponse',
          _$failedField,
          e.toString(),
        );
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
