import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';

abstract class ICartService {
  Future<void> addToCart(
    ProductModel product,
    String uid,
    int index,
    String category,
  );
  Future<void> removeById(String id, String uid);
  Future<void> clearCart(String uid);
  Future<void> setQuantity(CartItem cartItem, int quantity);
}
