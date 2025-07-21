import 'package:mobx/mobx.dart';

import '../services/sales/isales_service.dart';

part 'sales.store.g.dart';

class SalesStore = SalesStoreBase with _$SalesStore;

abstract class SalesStoreBase with Store {
  SalesStoreBase({required this.salesService});
  final ISalesService salesService;
}
