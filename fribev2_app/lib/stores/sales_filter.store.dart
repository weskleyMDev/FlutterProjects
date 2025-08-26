import 'package:decimal/decimal.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';

import '../models/sales_receipt.dart';

part 'sales_filter.store.g.dart';

class SalesFilterStore = SalesFilterStoreBase with _$SalesFilterStore;

abstract class SalesFilterStoreBase with Store {
  @observable
  ObservableMap<String, List<SalesReceipt>> _groupedSales =
      ObservableMap<String, List<SalesReceipt>>();

  @observable
  ObservableList<String> _sortedKeys = ObservableList<String>();

  @observable
  String _totalOfDay = '0.00';

  @computed
  Map<String, List<SalesReceipt>> get groupedSales => _groupedSales;

  @computed
  String get totalOfDay => _totalOfDay;

  @computed
  List<String> get sortedKeys => List.unmodifiable(_sortedKeys);

  @action
  void _updateSortedKeys() {
    final keys = _groupedSales.keys.toList();
    keys.sort((a, b) {
      final dateA = DateFormat('dd/MM/yyyy').parse(a);
      final dateB = DateFormat('dd/MM/yyyy').parse(b);
      return dateB.compareTo(dateA);
    });
    _sortedKeys
      ..clear()
      ..addAll(keys);
  }

  @action
  void setGroupedSales(List<SalesReceipt> sales) {
    _groupedSales.clear();
    for (var sale in sales) {
      final dateKey = DateFormat('dd/MM/yyyy').format(sale.createAt);
      if (!_groupedSales.containsKey(dateKey)) {
        _groupedSales[dateKey] = [];
      }
      _groupedSales[dateKey]!.add(sale);
    }
    _updateSortedKeys();
  }

  @action
  void setTotalOfDay(List<SalesReceipt> sales) {
    _totalOfDay = sales
        .fold(Decimal.zero, (sum, doc) => sum + Decimal.parse(doc.total))
        .toStringAsFixed(2);
  }
}
