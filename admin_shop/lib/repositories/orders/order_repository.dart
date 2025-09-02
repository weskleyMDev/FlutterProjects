import 'package:admin_shop/models/order_model.dart';
import 'package:admin_shop/repositories/orders/iorder_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';

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
  Stream<int> getUserOrdersCount(String userId) => _firestore
      .collection('orders')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map((snapshot) => snapshot.docs.length);

  @override
  Stream<double> getUserTotalOrders(String userId) => _firestore
      .collection('orders')
      .where('userId', isEqualTo: userId)
      .snapshots()
      .map(
        (snapshot) => snapshot.docs
            .fold<Decimal>(
              Decimal.zero,
              (total, doc) =>
                  total +
                  Decimal.parse((doc.data()['total'] as num).toString()),
            )
            .round(scale: 2)
            .toDouble(),
      );

  @override
  Stream<List<OrderModel>?> get orderStream => _fetchOrders();
}
