import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/repositories/products/iproducts_repository.dart';

class ProductsRepository implements IProductsRepository {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ProductModel>> getProductsByCategory({required String category}) {
    return _firestore
        .collection('stock')
        .doc(category)
        .collection('products')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('price')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  @override
  Future<ProductModel?> getProductById({
    required String category,
    required String id,
  }) async {
    final doc = await _firestore
        .collection('stock')
        .doc(category)
        .collection('products')
        .doc(id)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .get();
    return doc.exists ? doc.data() : null;
  }

  Map<String, dynamic> _toFirestore(
    ProductModel product,
    SetOptions? options,
  ) => product.toMap();

  ProductModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => ProductModel.fromMap(snapshot.data()!);
}
