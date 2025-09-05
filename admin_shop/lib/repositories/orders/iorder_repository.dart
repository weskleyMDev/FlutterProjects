import 'package:admin_shop/models/order_model.dart';

abstract interface class IOrderRepository {
  Stream<List<OrderModel>?> get orderStream;
  Future<void> setStatusCode(String oid, bool inc);
}
