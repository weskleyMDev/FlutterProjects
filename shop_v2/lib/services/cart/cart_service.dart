import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/services/cart/icart_service.dart';
import 'package:uuid/uuid.dart';

class CartService implements ICartService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Future<void> addToCart(
    ProductModel product,
    String uid,
    int index,
    String category,
  ) async {
    final data = CartItem(
      id: Uuid().v4(),
      quantity: 1,
      category: category,
      size: product.sizes[index],
      userId: uid,
      productId: product.id,
    );
    final docRef = FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(data.id);
    await docRef.set(data.toMap());
  }

  @override
  Future<void> clearCart(String uid) async {
    final snapshots = await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .get();

    for (var doc in snapshots.docs) {
      await doc.reference.delete();
    }
  }

  @override
  Future<void> removeById(String id, String uid) async {
    await _firestore
        .collection('users')
        .doc(uid)
        .collection('cart')
        .doc(id)
        .delete();
  }

  @override
  Future<void> setQuantity(CartItem cartItem, int quantity) async {
    await _firestore
        .collection('users')
        .doc(cartItem.userId)
        .collection('cart')
        .doc(cartItem.id)
        .update({'quantity': quantity});
  }
}
