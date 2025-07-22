import '../../models/sales_receipt.dart';
import '../../stores/cart.store.dart';

abstract class ISalesService {
  Stream<List<SalesReceipt>> getReceipts();
  Future<SalesReceipt?> createReceipt({required CartStore cart});
  Future<void> deleteReceiptById({required SalesReceipt receipt});
  Future<void> updateReceipt({required SalesReceipt receipt});
}
