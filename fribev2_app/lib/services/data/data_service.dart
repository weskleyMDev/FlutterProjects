import '../../models/product.dart';

abstract class IDataService {
  Stream<List<Product>> getProducts();
  Future<Product> save(Product product);
}
