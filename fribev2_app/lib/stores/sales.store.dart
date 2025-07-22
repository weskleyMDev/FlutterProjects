import 'package:mobx/mobx.dart';

import '../models/payment.dart';
import '../models/sales_receipt.dart';
import '../services/sales/isales_service.dart';
import 'cart.store.dart';

part 'sales.store.g.dart';

class SalesStore = SalesStoreBase with _$SalesStore;

abstract class SalesStoreBase with Store {
  SalesStoreBase({required this.salesService});
  final ISalesService salesService;

  @observable
  ObservableStream<List<SalesReceipt>> _receipts = ObservableStream(
    Stream<List<SalesReceipt>>.empty(),
  );

  @computed
  Stream<List<SalesReceipt>> get allReceipts => _receipts;

  @action
  Future<void> fetchReceipts() async {
    _receipts = ObservableStream(salesService.getReceipts());
  }

  @action
  Future<SalesReceipt?> createReceipt({
    required CartStore cart,
    required List<Payment> payments,
  }) async {
    final newReceipt = await salesService.createReceipt(
      cart: cart,
      payments: payments,
    );
    return newReceipt;
  }

  @action
  Future<void> deleteReceiptById({required SalesReceipt receipt}) async {
    await salesService.deleteReceiptById(receipt: receipt);
  }
}
