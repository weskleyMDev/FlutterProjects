import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/sales_receipt.dart';
import '../../stores/cart.store.dart';
import 'isales_service.dart';

class FirebaseSalesService implements ISalesService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<SalesReceipt>> getReceipts() {
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
  Future<void> deleteReceiptById({required SalesReceipt receipt}) async {
    await _firestore.collection('sales').doc(receipt.id).delete();
  }

  @override
  Future<SalesReceipt?> createReceipt({required CartStore cart}) async {
    final SalesReceipt newReceipt = SalesReceipt(
      id: '',
      total: cart.totalAmount,
      cart: cart.cartList.values.toList(),
      createAt: DateTime.now(),
    );

    final docRef = await _firestore
        .collection('sales')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(newReceipt);
    final doc = await docRef.get();

    return doc.data();
  }

  Map<String, dynamic> _toFirestore(
    SalesReceipt receipt,
    SetOptions? options,
  ) => receipt.toMap();

  SalesReceipt _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => SalesReceipt.fromMap(snapshot.data()!, snapshot.id);

  @override
  Future<void> updateReceipt({required SalesReceipt receipt}) async {
    await _firestore
        .collection('sales')
        .doc(receipt.id)
        .update(receipt.toMap());
  }
}
