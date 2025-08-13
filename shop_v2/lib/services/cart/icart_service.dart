import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';

abstract class ICartService {
  Future<void> addToCart(
    ProductModel product,
    String category,
    String uid,
    int index,
  );
  Future<void> removeById(String id, String uid);
  Future<void> clearCart();
  Future<void> setQuantity(CartItem cartItem, int quantity);
}
