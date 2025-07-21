import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/proof_sale.dart';
import 'isales_service.dart';

class FirebaseSalesService implements ISalesService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ProofSale?>> getSales() {
    final snapshots = _firestore
        .collection('sales')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createAt', descending: true)
        .snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<void> deleteProofById({required ProofSale proof}) async {
    await _firestore.collection('stock').doc(proof.id).delete();
  }

  @override
  Future<ProofSale?> saveProof({required ProofSale proof}) async {
    final ProofSale newProduct = ProofSale(
      id: '',
      amount: proof.amount,
      subtotal: proof.subtotal,
      total: proof.total,
      cart: proof.cart,
      createAt: proof.createAt,
    );

    final docRef = await _firestore
        .collection('sales')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(newProduct);
    final doc = await docRef.get();

    return doc.data();
  }

  Map<String, dynamic> _toFirestore(ProofSale product, SetOptions? options) =>
      product.toMap();

  ProofSale _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => ProofSale.fromMap(snapshot.data()!, snapshot.id);

  @override
  Future<void> updateProof({required ProofSale proof}) async {
    await _firestore.collection('sales').doc(proof.id).update(proof.toMap());
  }
}
