import 'package:admin_fribe/models/pending_sale_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';

part 'ipending_sale_repository.dart';

final class PendingSaleRepository implements IPendingSaleRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<PendingSaleModel>> getPendingSales() {
    return _firestore.collection('pending_sales').snapshots().switchMap((
      snapshot,
    ) {
      final pendingSale = PendingSaleModel.empty();
      final receiptStreams = snapshot.docs.map((doc) {
        return doc.reference
            .collection('pending_receipts')
            .withConverter(
              fromFirestore: _fromFirestore,
              toFirestore: _toFirestore,
            )
            .snapshots()
            .map((receiptSnapshot) {
              final receiptModels = receiptSnapshot.docs
                  .map((e) => e.data())
                  .toList();
              return pendingSale.copyWith(
                id: () => doc.id,
                receipts: () => receiptModels,
              );
            });
      }).toList();

      return receiptStreams.isEmpty
          ? Stream.value(<PendingSaleModel>[])
          : CombineLatestStream.list(receiptStreams);
    }).asBroadcastStream();
  }

  @override
  Future<void> updatePaymentStatus({
    required String pendingSaleId,
    required String receiptId,
    required bool status,
  }) async {
    final batch = _firestore.batch();

    final saleRef = _firestore.collection('pending_sales').doc(pendingSaleId);
    final receiptRef = saleRef.collection('pending_receipts').doc(receiptId);

    final now = Timestamp.fromDate(DateTime.now());

    final snapshot = await saleRef.get();
    Map<String, dynamic> paymentAtMap = {};

    if (snapshot.exists && snapshot.data() != null) {
      final data = snapshot.data()!;
      if (data['paymentAt'] != null &&
          data['paymentAt'] is Map<String, dynamic>) {
        paymentAtMap = Map<String, dynamic>.from(data['paymentAt']);
      }
    }

    paymentAtMap[receiptId] = now;

    batch.set(saleRef, {'paymentAt': paymentAtMap}, SetOptions(merge: true));

    batch.update(receiptRef, {'status': status});

    try {
      await batch.commit();
    } catch (e) {
      rethrow;
    }
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
