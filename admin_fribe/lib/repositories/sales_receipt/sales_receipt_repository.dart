part of 'isales_receipt_repository.dart';

final class SalesReceiptRepository implements ISalesReceiptRepository {
  final _firestore = FirebaseFirestore.instance;
  @override
  Stream<List<SalesReceipt>> getSalesReceiptsStream({
    required DateTime startDate,
    required DateTime endDate,
  }) {
    DateTime adjustedEndDate = DateTime(
      endDate.year,
      endDate.month,
      endDate.day,
    ).add(const Duration(days: 1));

    return _firestore
        .collection('sales')
        .withConverter<SalesReceipt>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .where('createAt', isGreaterThanOrEqualTo: startDate)
        .where('createAt', isLessThan: adjustedEndDate)
        .orderBy('createAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  @override
  Future<List<SalesReceipt>> getSalesReceiptsByMonth({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final querySnapshot = await _firestore
        .collection('sales')
        .withConverter<SalesReceipt>(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .where('createAt', isGreaterThanOrEqualTo: startDate)
        .where(
          'createAt',
          isLessThanOrEqualTo: endDate
              .add(const Duration(days: 1))
              .subtract(const Duration(milliseconds: 1)),
        )
        .orderBy('createAt', descending: true)
        .get();

    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

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
