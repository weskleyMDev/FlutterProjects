import 'package:fribev2_app/models/product.dart';

abstract class IStockRepository {
  Stream<List<Product>?> getProductByCategory(String category);
}
