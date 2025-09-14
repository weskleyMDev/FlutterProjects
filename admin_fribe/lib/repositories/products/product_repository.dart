import 'package:admin_fribe/models/product_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'iproduct_repository.dart';

final class ProductRepository implements IProductRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addProduct(ProductModel product) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteProduct(String id) {
    throw UnimplementedError();
  }

  @override
  Stream<List<ProductModel?>> getAllProducts() => _firestore
      .collection('stock')
      .withConverter<ProductModel>(
        fromFirestore: _fromFirestore,
        toFirestore: _toFirestore,
      )
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

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
  Future<void> updateProduct(ProductModel product) {
    throw UnimplementedError();
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
