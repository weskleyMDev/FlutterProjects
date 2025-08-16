import 'package:shop_v2/models/order/order_model.dart';

abstract class IOrderRepository {
  Stream<List<OrderModel>> getOrders(String uid);
}
