part of 'isales_receipt_repository.dart';

final class SalesReceiptRepository implements ISalesReceiptRepository {
  final _firestore = FirebaseFirestore.instance;
  @override
  Stream<List<SalesReceipt>> getSalesReceiptsStream() => _firestore
      .collection('sales')
      .withConverter<SalesReceipt>(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      )
      .orderBy('createAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

  Map<String, dynamic> _toFirestore(
    SalesReceipt salesReceipt,
    SetOptions? options,
  ) => salesReceipt.toMap();

  SalesReceipt _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) return SalesReceipt.initial();
    return SalesReceipt.fromMap(data);
  }
}
