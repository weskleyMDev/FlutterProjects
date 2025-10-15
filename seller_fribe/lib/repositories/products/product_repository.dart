import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:seller_fribe/models/product_model.dart';

part 'iproduct_repository.dart';

final class ProductRepository implements IProductRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ProductModel>?> get productFromFirebase => _firestore
      .collection('stock')
      .withConverter<ProductModel>(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      )
      .orderBy('name')
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

  @override
  Future<void> updateAmountProduct(
    String productId,
    String amountToSubtract,
  ) async {
    try {
      final docRef = _firestore
          .collection('stock')
          .doc(productId)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          );
      final snapshot = await docRef.get();
      final data = snapshot.data();
      if (data == null) {
        throw Exception('Product with ID $productId does not exist.');
      }
      final currentAmount = data.amount;
      final toDecimal = Decimal.parse(currentAmount.trim());
      final toSubtract = Decimal.parse(amountToSubtract.trim());
      final newAmount = (toDecimal - toSubtract).round(scale: 3);
      if (newAmount < Decimal.zero) {
        throw Exception(
          'Insufficient stock for product ID $productId. Current amount: $currentAmount, attempted to subtract: $amountToSubtract.',
        );
      }
      await docRef.update({'amount': newAmount.toString()});
    } catch (_) {
      rethrow;
    }
  }

  Map<String, dynamic> _toFirestore(
    ProductModel product,
    SetOptions? options,
  ) => product.toMap();

  ProductModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('Product data is null');
    return ProductModel.fromMap(data);
  }
}
