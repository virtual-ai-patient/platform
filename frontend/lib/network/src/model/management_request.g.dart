// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'management_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$ManagementRequest extends ManagementRequest {
  @override
  final BuiltList<String> diagnosticPlan;
  @override
  final BuiltList<String> treatmentPlan;
  @override
  final BuiltList<String> contraindications;
  @override
  final BuiltList<String> followUp;

  factory _$ManagementRequest(
          [void Function(ManagementRequestBuilder)? updates]) =>
      (ManagementRequestBuilder()..update(updates))._build();

  _$ManagementRequest._(
      {required this.diagnosticPlan,
      required this.treatmentPlan,
      required this.contraindications,
      required this.followUp})
      : super._();
  @override
  ManagementRequest rebuild(void Function(ManagementRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  ManagementRequestBuilder toBuilder() =>
      ManagementRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is ManagementRequest &&
        diagnosticPlan == other.diagnosticPlan &&
        treatmentPlan == other.treatmentPlan &&
        contraindications == other.contraindications &&
        followUp == other.followUp;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, diagnosticPlan.hashCode);
    _$hash = $jc(_$hash, treatmentPlan.hashCode);
    _$hash = $jc(_$hash, contraindications.hashCode);
    _$hash = $jc(_$hash, followUp.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'ManagementRequest')
          ..add('diagnosticPlan', diagnosticPlan)
          ..add('treatmentPlan', treatmentPlan)
          ..add('contraindications', contraindications)
          ..add('followUp', followUp))
        .toString();
  }
}

class ManagementRequestBuilder
    implements Builder<ManagementRequest, ManagementRequestBuilder> {
  _$ManagementRequest? _$v;

  ListBuilder<String>? _diagnosticPlan;
  ListBuilder<String> get diagnosticPlan =>
      _$this._diagnosticPlan ??= ListBuilder<String>();
  set diagnosticPlan(ListBuilder<String>? diagnosticPlan) =>
      _$this._diagnosticPlan = diagnosticPlan;

  ListBuilder<String>? _treatmentPlan;
  ListBuilder<String> get treatmentPlan =>
      _$this._treatmentPlan ??= ListBuilder<String>();
  set treatmentPlan(ListBuilder<String>? treatmentPlan) =>
      _$this._treatmentPlan = treatmentPlan;

  ListBuilder<String>? _contraindications;
  ListBuilder<String> get contraindications =>
      _$this._contraindications ??= ListBuilder<String>();
  set contraindications(ListBuilder<String>? contraindications) =>
      _$this._contraindications = contraindications;

  ListBuilder<String>? _followUp;
  ListBuilder<String> get followUp =>
      _$this._followUp ??= ListBuilder<String>();
  set followUp(ListBuilder<String>? followUp) => _$this._followUp = followUp;

  ManagementRequestBuilder() {
    ManagementRequest._defaults(this);
  }

  ManagementRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _diagnosticPlan = $v.diagnosticPlan.toBuilder();
      _treatmentPlan = $v.treatmentPlan.toBuilder();
      _contraindications = $v.contraindications.toBuilder();
      _followUp = $v.followUp.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(ManagementRequest other) {
    _$v = other as _$ManagementRequest;
  }

  @override
  void update(void Function(ManagementRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  ManagementRequest build() => _build();

  _$ManagementRequest _build() {
    _$ManagementRequest _$result;
    try {
      _$result = _$v ??
          _$ManagementRequest._(
            diagnosticPlan: diagnosticPlan.build(),
            treatmentPlan: treatmentPlan.build(),
            contraindications: contraindications.build(),
            followUp: followUp.build(),
          );
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'diagnosticPlan';
        diagnosticPlan.build();
        _$failedField = 'treatmentPlan';
        treatmentPlan.build();
        _$failedField = 'contraindications';
        contraindications.build();
        _$failedField = 'followUp';
        followUp.build();
      } catch (e) {
        throw BuiltValueNestedFieldError(
            r'ManagementRequest', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
