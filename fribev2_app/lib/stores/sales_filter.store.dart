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
  List<String> get sortedKeys {
    _sortedKeys.clear();
    _sortedKeys.addAll(
      _groupedSales.keys.toList()..sort(
        (a, b) => DateFormat(
          'dd/MM/yyyy',
        ).parse(b).compareTo(DateFormat('dd/MM/yyyy').parse(a)),
      ),
    );
    return _sortedKeys;
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
  }

  @action
  void setTotalOfDay(List<SalesReceipt> sales) {
    _totalOfDay = sales
        .fold(Decimal.zero, (sum, doc) => sum + Decimal.parse(doc.total))
        .toStringAsFixed(2);
  }
}
