import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../../models/product.dart';
import 'istock_service.dart';

class FirebaseStockService implements IStockService {
  static final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<Product>> getProducts() {
    final snapshots = _firestore
        .collection('stock')
        .orderBy('name')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .snapshots();
    return snapshots
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  @override
  Future<Product?> saveProduct({required Product product}) async {
    final docRef = await _firestore
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .add(product);
    final doc = await docRef.get();

    return doc.data();
  }

  @override
  Future<Product?> getProductById({required String id}) async {
    final doc = await _firestore
        .collection('stock')
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .doc(id)
        .get();
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
  Future<void> updateProductById({required Product product}) async {
    await _firestore
        .collection('stock')
        .doc(product.id)
        .update(product.toMap());
  }

  @override
  Future<void> updateQuantityById({
    required String id,
    required String quantity,
  }) async {
    await _firestore.collection('stock').doc(id).update({'amount': quantity});
  }
}
