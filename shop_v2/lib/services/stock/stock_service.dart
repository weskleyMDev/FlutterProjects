import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/product/product.dart';
import 'package:shop_v2/services/stock/istock_service.dart';

class StockService implements IStockService {
  static final _firestore = FirebaseFirestore.instance;

  Stream<List<Product>> _fetchProducts() {
    return _firestore
        .collection('home')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('pos')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Map<String, dynamic> _toFirestore(Product product, SetOptions? options) =>
      product.toMap();

  Product _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Product.fromMap(snapshot.data()!);

  @override
  Stream<List<Product>> get products => _fetchProducts();
}
