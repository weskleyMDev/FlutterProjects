import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/products/products_off.dart';
import 'package:shop_v2/services/showcase/ishowcase_service.dart';

class ShowcaseService implements IShowcaseService {
  static final _firestore = FirebaseFirestore.instance;

  Stream<List<ProductOff>> _fetchProducts() {
    return _firestore
        .collection('home')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('pos')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList());
  }

  Map<String, dynamic> _toFirestore(ProductOff product, SetOptions? options) =>
      product.toMap();

  ProductOff _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => ProductOff.fromMap(snapshot.data()!);

  @override
  Stream<List<ProductOff>> get products => _fetchProducts();
}
