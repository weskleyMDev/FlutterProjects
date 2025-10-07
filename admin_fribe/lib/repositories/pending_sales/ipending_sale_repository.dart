part of 'pending_sale_repository.dart';

abstract interface class IPendingSaleRepository {
  Stream<List<PendingSaleModel>> getPendingSales();
  Future<void> updatePaymentStatus({
    required String pendingSaleId,
    required String receiptId,
    required bool status,
  });
}
