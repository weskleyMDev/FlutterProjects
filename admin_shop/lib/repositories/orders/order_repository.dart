import 'package:admin_shop/models/order_model.dart';
import 'package:admin_shop/repositories/orders/iorder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final class OrderRepository implements IOrderRepository {
  final _firestore = FirebaseFirestore.instance;

  Stream<List<OrderModel>?> _fetchOrders() => _firestore
      .collection('orders')
      .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
      .asBroadcastStream();

  Map<String, dynamic> _toFirestore(OrderModel order, SetOptions? options) =>
      order.toMap();

  OrderModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data();
    if (data == null) throw Exception('Invalid data');
    return OrderModel.fromMap(data);
  }

  @override
  Future<void> setStatusCode(String oid, bool inc) async {
    try {
      final orderDoc = await _firestore
          .collection('orders')
          .doc(oid)
          .withConverter(
            fromFirestore: _fromFirestore,
            toFirestore: _toFirestore,
          )
          .get();
      if (!orderDoc.exists) throw Exception('Order not found!');
      final order = orderDoc.data();
      if (order == null) throw Exception('Invalid order data!');
      final currentStatus = order.status;
      if (currentStatus < 1 || currentStatus > 3) {
        throw Exception('Invalid status value!');
      }
      num nextStatus = 0;
      if (inc) {
        nextStatus = currentStatus < 3 ? currentStatus + 1 : currentStatus;
      } else {
        nextStatus = currentStatus > 1 ? currentStatus - 1 : currentStatus;
      }
      await _firestore.collection('orders').doc(oid).update({
        'status': nextStatus,
      });
    } catch (e) {
      rethrow;
    }
  }

  @override
  Stream<List<OrderModel>?> get orderStream => _fetchOrders();
}
