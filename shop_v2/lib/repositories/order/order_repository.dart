import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shop_v2/models/order/order_model.dart';
import 'package:shop_v2/repositories/order/iorder_repository.dart';

class OrderRepository implements IOrderRepository {
  final _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<OrderModel>> getOrders(String uid) {
    return _firestore
        .collection('orders')
        .where('userId', isEqualTo: uid)
        .withConverter(fromFirestore: _fromFirestore, toFirestore: _toFirestore)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.data()).toList())
        .asBroadcastStream();
  }

  Map<String, dynamic> _toFirestore(OrderModel order, SetOptions? options) =>
      order.toMap();

  OrderModel _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) => OrderModel.fromMap(snapshot.data()!);
}
