import 'package:mobx/mobx.dart';
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

  @action
  Future<void> fetchReceipts() async {
    _receipts = ObservableStream(salesService.getReceipts());
  }

  @computed
  Stream<List<SalesReceipt>> get allReceipts => _receipts;

  @action
  Future<SalesReceipt?> createReceipt({required CartStore cart}) async {
    final newReceipt = await salesService.createReceipt(cart: cart);
    return newReceipt;
  }

  @action
  Future<void> deleteReceiptById({required SalesReceipt receipt}) async {
    await salesService.deleteReceiptById(receipt: receipt);
  }
}
