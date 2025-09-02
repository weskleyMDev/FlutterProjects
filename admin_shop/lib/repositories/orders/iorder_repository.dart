import 'package:admin_shop/models/order_model.dart';

abstract interface class IOrderRepository {
  Stream<List<OrderModel>?> get orderStream;
  Stream<int> getUserOrdersCount(String userId);
  Stream<double> getUserTotalOrders(String userId);
}
