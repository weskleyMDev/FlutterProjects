import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fribev2_app/models/product.dart';
import 'package:fribev2_app/repository/istock_repository.dart';

class StockRepository implements IStockRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Product>?> getProductByCategory(String category) => _firestore
      .collection('products')
      .where('category', isEqualTo: category.toUpperCase())
      .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
      .snapshots()
      .map(
        (snapshot) =>
            snapshot.docs.map((doc) => doc.data()).toList(),
      )
      .asBroadcastStream();

  Map<String, dynamic> _toFirestore(Product product, SetOptions? options) =>
      product.toMap();

  Product _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Product.fromMap(snapshot.data()!, snapshot.id);
}
