import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';
import 'stock_service.dart';

class FirebaseStockService implements IStockService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getProducts() {
    final snapshots = _firestore
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('name')
        .snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Product?> saveProduct({required StockFormData product}) async {
    final Product newProduct = Product(
      name: product.name,
      category: product.category,
      measure: product.measure,
      amount: product.amount,
      price: product.price,
    );

    final docRef = await _firestore
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(newProduct);
    final doc = await docRef.get();

    return doc.data();
  }

  Map<String, dynamic> _toFirestore(Product product, SetOptions? options) =>
      product.toMap();

  Product _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => Product.fromMap(snapshot.data()!, snapshot.id);

  @override
  Future<void> clearByCategory({required String category}) async {
    final querySnapshot = await _firestore
        .collection('stock')
        .where('category', isEqualTo: category)
        .get();

    final batch = _firestore.batch();

    for (final doc in querySnapshot.docs) {
      batch.delete(doc.reference);
    }

    await batch.commit();
  }

  @override
  Future<void> deleteProductById({required Product product}) async {
    await _firestore.collection('stock').doc(product.id).delete();
  }

  @override
  Future<void> updateProductById({
    required Product product,
    required StockFormData data,
  }) async {
    await _firestore.collection('stock').doc(product.id).update(data.toMap());
  }
}
