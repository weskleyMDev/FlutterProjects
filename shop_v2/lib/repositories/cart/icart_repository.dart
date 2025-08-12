import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/user/app_user.dart';

abstract class ICartRepository {
  Stream<List<CartItem>> cartStream(AppUser user);
}
