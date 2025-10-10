import 'package:admin_fribe/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';

part 'iproduct_repository.dart';

final class ProductRepository implements IProductRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addProduct(ProductModel product) async {
    try {
      final docRef = _firestore.collection('stock').doc();
      final newProduct = product.copyWith(id: () => docRef.id);
      await docRef
          .withConverter<ProductModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .set(newProduct);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteProduct(String id) {
    try {
      return _firestore.collection('stock').doc(id).delete();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<ProductModel>> getAllProducts() {
    try {
      return _firestore
          .collection('stock')
          .withConverter<ProductModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .orderBy('name')
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
          .asBroadcastStream();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<ProductModel> getProductById(String id) async {
    try {
      final product = await _firestore
          .collection('stock')
          .doc(id)
          .withConverter<ProductModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();
      if (product.data() == null) {
        throw Exception('Product not found');
      } else {
        return product.data()!;
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    try {
      final docSnapshot = await _firestore
          .collection('stock')
          .doc(product.id)
          .withConverter<ProductModel>(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();

      if (!docSnapshot.exists || docSnapshot.data() == null) {
        throw Exception('Product not found');
      }
      final existingProduct = docSnapshot.data()!;
      final currentAmount =
          Decimal.tryParse(
            existingProduct.amount.isNotEmpty ? existingProduct.amount : '0',
          ) ??
          Decimal.zero;
      final newAmount =
          Decimal.tryParse(product.amount.isNotEmpty ? product.amount : '0') ??
          Decimal.zero;
      final updatedAmount = (currentAmount + newAmount).round(scale: 3);
      final updatedProduct = product.copyWith(
        amount: () => updatedAmount.toString(),
      );
      await docSnapshot.reference.update(updatedProduct.toMap());
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
    if (data == null) {
      throw Exception('Invalid product data!');
    }
    return ProductModel.fromMap(data);
  }
}
