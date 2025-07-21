import '../../models/proof_sale.dart';

abstract class ISalesService {
  Stream<List<ProofSale?>> getSales();
  Future<ProofSale?> saveProof({required ProofSale proof});
  Future<void> deleteProofById({required ProofSale proof});
  Future<void> updateProof({required ProofSale proof});
}
