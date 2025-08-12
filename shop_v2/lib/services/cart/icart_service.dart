import 'package:shop_v2/models/products/product_model.dart';

abstract class ICartService {
  Future<void> addToCart(ProductModel product);
  Future<void> removeById(String id);
  Future<void> clearCart();
}
