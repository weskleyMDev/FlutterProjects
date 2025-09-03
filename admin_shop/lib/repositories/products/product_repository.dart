import 'package:admin_shop/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iproduct_repository.dart';

final class ProductRepository implements IProductRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<ProductModel>> fetchDataFromFirestore(String category) =>
      _firestore
          .collection('stock')
          .doc(category)
          .collection('products')
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
          .asBroadcastStream();

  Map<String, dynamic> _toFirestore(
    ProductModel product,
    SetOptions? options,
  ) => product.toMap();

  ProductModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) return ProductModel.empty();
    return ProductModel.fromMap(data);
  }
}
