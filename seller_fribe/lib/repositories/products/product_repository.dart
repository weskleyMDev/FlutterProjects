import 'package:cloud_firestore/cloud_firestore.dart';
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
  Future<void> updateAmountProduct(ProductModel product) async {
    try {
      await _firestore.collection('stock').doc(product.id).update({
        'amount': product.amount,
      });
    } catch (e) {
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
