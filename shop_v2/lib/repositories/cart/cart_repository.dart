import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/cart/cart_item.dart';
import 'package:shop_v2/models/user/app_user.dart';
import 'package:shop_v2/repositories/cart/icart_repository.dart';

class CartRepository implements ICartRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<CartItem>> cartStream(AppUser user) {
    try {
      return _firestore
          .collection('users')
          .doc(user.id)
          .collection('cart')
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .snapshots()
          .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
          .asBroadcastStream();
    } catch (e) {
      rethrow;
    }
  }

  Map<String, dynamic> _toFirestore(CartItem cartItem, SetOptions? options) =>
      cartItem.toMap();

  CartItem _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => CartItem.fromMap(snapshot.data()!);
}
