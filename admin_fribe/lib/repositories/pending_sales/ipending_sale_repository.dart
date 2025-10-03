part of 'pending_sale_repository.dart';

abstract interface class IPendingSaleRepository {
  Stream<List<PendingSaleModel>> getPendingSales();
}
