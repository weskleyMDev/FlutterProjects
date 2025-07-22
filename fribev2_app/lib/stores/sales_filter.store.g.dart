// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_filter.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$SalesFilterStore on SalesFilterStoreBase, Store {
  Computed<Map<String, List<SalesReceipt>>>? _$groupedSalesComputed;

  @override
  Map<String, List<SalesReceipt>> get groupedSales =>
      (_$groupedSalesComputed ??= Computed<Map<String, List<SalesReceipt>>>(
        () => super.groupedSales,
        name: 'SalesFilterStoreBase.groupedSales',
      )).value;
  Computed<String>? _$totalOfDayComputed;

  @override
  String get totalOfDay => (_$totalOfDayComputed ??= Computed<String>(
    () => super.totalOfDay,
    name: 'SalesFilterStoreBase.totalOfDay',
  )).value;
  Computed<List<String>>? _$sortedKeysComputed;

  @override
  List<String> get sortedKeys =>
      (_$sortedKeysComputed ??= Computed<List<String>>(
        () => super.sortedKeys,
        name: 'SalesFilterStoreBase.sortedKeys',
      )).value;

  late final _$_groupedSalesAtom = Atom(
    name: 'SalesFilterStoreBase._groupedSales',
    context: context,
  );

  @override
  ObservableMap<String, List<SalesReceipt>> get _groupedSales {
    _$_groupedSalesAtom.reportRead();
    return super._groupedSales;
  }

  @override
  set _groupedSales(ObservableMap<String, List<SalesReceipt>> value) {
    _$_groupedSalesAtom.reportWrite(value, super._groupedSales, () {
      super._groupedSales = value;
    });
  }

  late final _$_sortedKeysAtom = Atom(
    name: 'SalesFilterStoreBase._sortedKeys',
    context: context,
  );

  @override
  ObservableList<String> get _sortedKeys {
    _$_sortedKeysAtom.reportRead();
    return super._sortedKeys;
  }

  @override
  set _sortedKeys(ObservableList<String> value) {
    _$_sortedKeysAtom.reportWrite(value, super._sortedKeys, () {
      super._sortedKeys = value;
    });
  }

  late final _$_totalOfDayAtom = Atom(
    name: 'SalesFilterStoreBase._totalOfDay',
    context: context,
  );

  @override
  String get _totalOfDay {
    _$_totalOfDayAtom.reportRead();
    return super._totalOfDay;
  }

  @override
  set _totalOfDay(String value) {
    _$_totalOfDayAtom.reportWrite(value, super._totalOfDay, () {
      super._totalOfDay = value;
    });
  }

  late final _$SalesFilterStoreBaseActionController = ActionController(
    name: 'SalesFilterStoreBase',
    context: context,
  );

  @override
  void setGroupedSales(List<SalesReceipt> sales) {
    final _$actionInfo = _$SalesFilterStoreBaseActionController.startAction(
      name: 'SalesFilterStoreBase.setGroupedSales',
    );
    try {
      return super.setGroupedSales(sales);
    } finally {
      _$SalesFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setTotalOfDay(List<SalesReceipt> sales) {
    final _$actionInfo = _$SalesFilterStoreBaseActionController.startAction(
      name: 'SalesFilterStoreBase.setTotalOfDay',
    );
    try {
      return super.setTotalOfDay(sales);
    } finally {
      _$SalesFilterStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
groupedSales: ${groupedSales},
totalOfDay: ${totalOfDay},
sortedKeys: ${sortedKeys}
    ''';
  }
}
