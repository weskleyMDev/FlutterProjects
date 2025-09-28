import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_fribe/models/receipt_model.dart';

part 'ireceipt_repository.dart';

final class ReceiptRepository implements IReceiptRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ReceiptModel>> getReceipts() => _firestore
      .collection('sales')
      .withConverter<ReceiptModel>(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      )
      .orderBy('createAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

  @override
  Future<void> saveReceipt(ReceiptModel receiptData) async {
    try {
      await _firestore
          .collection('sales')
          .doc(receiptData.id)
          .withConverter<ReceiptModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .set(receiptData);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> savePendingReceipt(ReceiptModel receiptData, String client) async {
    try {
      await _firestore
          .collection('pending_sales')
          .doc(client)
          .collection('pending_receipts')
          .doc(receiptData.id)
          .withConverter<ReceiptModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .set(receiptData);
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _toFirestore(
    ReceiptModel receipt,
    SetOptions? options,
  ) => receipt.toMap();

  ReceiptModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('Receipt data is null');
    return ReceiptModel.fromMap(data);
  }
}
