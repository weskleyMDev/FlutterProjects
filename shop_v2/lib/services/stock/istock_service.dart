import 'package:shop_v2/models/product/product.dart';

abstract class IStockService {
  Stream<List<Product>> get products;
}
