// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'medication.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$Medication extends Medication {
  @override
  final String name;
  @override
  final String dose;
  @override
  final String route;

  factory _$Medication([void Function(MedicationBuilder)? updates]) =>
      (MedicationBuilder()..update(updates))._build();

  _$Medication._({required this.name, required this.dose, required this.route})
      : super._();
  @override
  Medication rebuild(void Function(MedicationBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  MedicationBuilder toBuilder() => MedicationBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is Medication &&
        name == other.name &&
        dose == other.dose &&
        route == other.route;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, name.hashCode);
    _$hash = $jc(_$hash, dose.hashCode);
    _$hash = $jc(_$hash, route.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'Medication')
          ..add('name', name)
          ..add('dose', dose)
          ..add('route', route))
        .toString();
  }
}

class MedicationBuilder implements Builder<Medication, MedicationBuilder> {
  _$Medication? _$v;

  String? _name;
  String? get name => _$this._name;
  set name(String? name) => _$this._name = name;

  String? _dose;
  String? get dose => _$this._dose;
  set dose(String? dose) => _$this._dose = dose;

  String? _route;
  String? get route => _$this._route;
  set route(String? route) => _$this._route = route;

  MedicationBuilder() {
    Medication._defaults(this);
  }

  MedicationBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _dose = $v.dose;
      _route = $v.route;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(Medication other) {
    _$v = other as _$Medication;
  }

  @override
  void update(void Function(MedicationBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  Medication build() => _build();

  _$Medication _build() {
    final _$result = _$v ??
        _$Medication._(
          name: BuiltValueNullFieldError.checkNotNull(
              name, r'Medication', 'name'),
          dose: BuiltValueNullFieldError.checkNotNull(
              dose, r'Medication', 'dose'),
          route: BuiltValueNullFieldError.checkNotNull(
              route, r'Medication', 'route'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
