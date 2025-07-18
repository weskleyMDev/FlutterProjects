import '../../models/form_data/stock_form_data.dart';
import '../../models/product.dart';

abstract class IDataService {
  Stream<List<Product>> getProducts();
  Future<Product?> save({required StockFormData product});
}
