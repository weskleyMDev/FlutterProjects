part of 'product_repository.dart';

abstract interface class IProductRepository {
  Stream<List<ProductModel>> getAllProducts();
  Future<ProductModel> getProductById(String id);
  Future<void> addProduct(ProductModel product);
  Future<void> updateProduct(ProductModel product);
  Future<void> deleteProduct(String id);
}
