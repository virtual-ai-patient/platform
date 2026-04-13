// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'start_session_request.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$StartSessionRequest extends StartSessionRequest {
  @override
  final String caseId;

  factory _$StartSessionRequest(
          [void Function(StartSessionRequestBuilder)? updates]) =>
      (StartSessionRequestBuilder()..update(updates))._build();

  _$StartSessionRequest._({required this.caseId}) : super._();
  @override
  StartSessionRequest rebuild(
          void Function(StartSessionRequestBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  StartSessionRequestBuilder toBuilder() =>
      StartSessionRequestBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is StartSessionRequest && caseId == other.caseId;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, caseId.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'StartSessionRequest')
          ..add('caseId', caseId))
        .toString();
  }
}

class StartSessionRequestBuilder
    implements Builder<StartSessionRequest, StartSessionRequestBuilder> {
  _$StartSessionRequest? _$v;

  String? _caseId;
  String? get caseId => _$this._caseId;
  set caseId(String? caseId) => _$this._caseId = caseId;

  StartSessionRequestBuilder() {
    StartSessionRequest._defaults(this);
  }

  StartSessionRequestBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _caseId = $v.caseId;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(StartSessionRequest other) {
    _$v = other as _$StartSessionRequest;
  }

  @override
  void update(void Function(StartSessionRequestBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  StartSessionRequest build() => _build();

  _$StartSessionRequest _build() {
    final _$result = _$v ??
        _$StartSessionRequest._(
          caseId: BuiltValueNullFieldError.checkNotNull(
              caseId, r'StartSessionRequest', 'caseId'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
