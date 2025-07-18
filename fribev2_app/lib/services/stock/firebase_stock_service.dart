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
        .orderBy('name', descending: true)
        .snapshots();
    return snapshots.map(
      (snapshot) => snapshot.docs.map((doc) => doc.data()).toList(),
    );
  }

  @override
  Future<Product?> save({required StockFormData product}) async {
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
}
