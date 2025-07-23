import '../../models/product.dart';

abstract class IStockService {
  Stream<List<Product>> getProducts();
  Future<Product?> saveProduct({required Product product});
  Future<void> deleteProductById({required Product product});
  Future<void> updateProductById({required Product product});
  Future<void> clearByCategory({required String category});
  Future<void> updateQuantityById({required String id, required String quantity});
}
