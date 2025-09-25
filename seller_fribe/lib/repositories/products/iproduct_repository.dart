part of 'product_repository.dart';

abstract interface class IProductRepository {
  Stream<List<ProductModel>?> get productFromFirebase;
  Future<void> updateAmountProduct(ProductModel product);
}
