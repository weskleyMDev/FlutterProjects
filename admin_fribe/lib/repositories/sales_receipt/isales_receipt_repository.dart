import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
part 'sales_receipt_repository.dart';

abstract interface class ISalesReceiptRepository {
  Stream<List<SalesReceipt>> getSalesReceiptsStream();
}
