import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';

abstract class IStockService {
  Stream<List<Product>> getProducts();
  Future<Product?> saveProduct({required StockFormData product});
  Future<void> deleteProductById({required Product product});
  Future<void> updateProductById({
    required Product product,
    required StockFormData data,
  });
  Future<void> clearByCategory({required String category});
}
