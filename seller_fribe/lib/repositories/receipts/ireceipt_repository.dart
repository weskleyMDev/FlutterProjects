part of 'receipt_repository.dart';

abstract interface class IReceiptRepository {
  Stream<List<ReceiptModel>> getReceipts();
  Future<void> saveReceipt(ReceiptModel receiptData);
  Future<void> savePendingReceipt(ReceiptModel receiptData, String client);
}