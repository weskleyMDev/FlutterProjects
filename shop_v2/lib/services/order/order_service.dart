import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/order/order_model.dart';
import 'package:shop_v2/services/order/iorder_service.dart';
import 'package:uuid/uuid.dart';

class OrderService implements IOrderService {
  final _firestore = FirebaseFirestore.instance;

  @override
  Future<void> saveOrder(Map<String, dynamic> data) async {
    final newOrder = OrderModel(
      id: Uuid().v4(),
      userId: data['userId'],
      createdAt: DateTime.now(),
      products: data['products'],
      total: data['total'],
      coupon: data['coupon'],
    );

    await _firestore
        .collection('orders')
        .doc(newOrder.id)
        .set(newOrder.toMap());
  }
}
