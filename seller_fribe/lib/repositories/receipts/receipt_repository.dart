import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:seller_fribe/models/receipt_model.dart';

part 'ireceipt_repository.dart';

final class ReceiptRepository implements IReceiptRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ReceiptModel>> getReceipts() {
    try {
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);
      final twoDaysAgo = today.subtract(Duration(days: 2));
      final endOfToday = today
          .add(Duration(days: 1))
          .subtract(Duration(milliseconds: 1));

      return _firestore
          .collection('sales')
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .where('createAt', isGreaterThanOrEqualTo: twoDaysAgo)
          .where('createAt', isLessThanOrEqualTo: endOfToday)
          .orderBy('createAt', descending: true)
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
          .asBroadcastStream();
    } catch (_) {
      rethrow;
    }
  }

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
  Future<void> savePendingReceipt(
    ReceiptModel receiptData,
    String client,
  ) async {
    try {
      await Future.wait([
        _firestore.collection('pending_sales').doc(client).set({
          'name': client,
        }, SetOptions(merge: true)),
        _firestore
            .collection('pending_sales')
            .doc(client)
            .collection('pending_receipts')
            .doc(receiptData.id)
            .withConverter<ReceiptModel>(
              fromFirestore: _fromFirestore,
              toFirestore: _toFirestore,
            )
            .set(receiptData),
      ]);
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
