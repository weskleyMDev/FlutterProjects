import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';

abstract class IStockService {
  Stream<List<Product>> getProducts();
  Future<Product?> save({required StockFormData product});
}
