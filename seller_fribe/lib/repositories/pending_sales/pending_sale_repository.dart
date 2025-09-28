import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rxdart/rxdart.dart';
import 'package:seller_fribe/models/pending_receipt_model.dart';
import 'package:seller_fribe/models/receipt_model.dart';

part 'ipending_sale_repository.dart';

final class PendingSaleRepository implements IPendingSaleRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<PendingReceiptModel>> getPendingReceiptsGroupedById() {
    return _firestore.collection('pending_sales').snapshots().switchMap((
      snapshot,
    ) {
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
              return PendingReceiptModel.empty().copyWith(
                id: () => doc.id,
                receipts: () => receiptModels,
              );
            });
      }).toList();

      return receiptStreams.isEmpty
          ? Stream.value(<PendingReceiptModel>[])
          : CombineLatestStream.list(receiptStreams);
    }).asBroadcastStream();
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
