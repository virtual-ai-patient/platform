// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'available_test_item.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$AvailableTestItem extends AvailableTestItem {
  @override
  final String testName;
  @override
  final String category;

  factory _$AvailableTestItem(
          [void Function(AvailableTestItemBuilder)? updates]) =>
      (AvailableTestItemBuilder()..update(updates))._build();

  _$AvailableTestItem._({required this.testName, required this.category})
      : super._();
  @override
  AvailableTestItem rebuild(void Function(AvailableTestItemBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  AvailableTestItemBuilder toBuilder() =>
      AvailableTestItemBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is AvailableTestItem &&
        testName == other.testName &&
        category == other.category;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, testName.hashCode);
    _$hash = $jc(_$hash, category.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper(r'AvailableTestItem')
          ..add('testName', testName)
          ..add('category', category))
        .toString();
  }
}

class AvailableTestItemBuilder
    implements Builder<AvailableTestItem, AvailableTestItemBuilder> {
  _$AvailableTestItem? _$v;

  String? _testName;
  String? get testName => _$this._testName;
  set testName(String? testName) => _$this._testName = testName;

  String? _category;
  String? get category => _$this._category;
  set category(String? category) => _$this._category = category;

  AvailableTestItemBuilder() {
    AvailableTestItem._defaults(this);
  }

  AvailableTestItemBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _testName = $v.testName;
      _category = $v.category;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(AvailableTestItem other) {
    _$v = other as _$AvailableTestItem;
  }

  @override
  void update(void Function(AvailableTestItemBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  AvailableTestItem build() => _build();

  _$AvailableTestItem _build() {
    final _$result = _$v ??
        _$AvailableTestItem._(
          testName: BuiltValueNullFieldError.checkNotNull(
              testName, r'AvailableTestItem', 'testName'),
          category: BuiltValueNullFieldError.checkNotNull(
              category, r'AvailableTestItem', 'category'),
        );
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
