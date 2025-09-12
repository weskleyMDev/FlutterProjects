import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:uuid/uuid.dart';

import '../../models/payment.dart';
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
    return snapshots
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  @override
  Future<void> deleteReceiptById({required SalesReceipt receipt}) async {
    await _firestore.collection('sales').doc(receipt.id).delete();
  }

  @override
  Future<SalesReceipt> createReceipt({
    required CartStore cart,
    required List<Payment> payments,
  }) async {
    final SalesReceipt newReceipt = SalesReceipt(
      id: Uuid().v4(),
      total: cart.total.toStringAsFixed(2),
      cart: cart.cartList,
      createAt: DateTime.now(),
      payments: payments,
      discount: cart.discount,
      shipping: cart.shipping,
      discountReason: cart.discountReason,
      tariffs: cart.tariffs,
    );

    await _firestore
        .collection('sales')
        .doc(newReceipt.id)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .set(newReceipt);

    return newReceipt;
  }

  Map<String, dynamic> _toFirestore(
    SalesReceipt receipt,
    SetOptions? options,
  ) => receipt.toMap();

  SalesReceipt _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => SalesReceipt.fromMap(snapshot.data()!);

  @override
  Future<void> updateReceipt({required SalesReceipt receipt}) async {
    await _firestore
        .collection('sales')
        .doc(receipt.id)
        .update(receipt.toMap());
  }
}
