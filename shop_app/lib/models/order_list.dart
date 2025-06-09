
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  static OrderList? _instance = OrderList._internal();

  OrderList._internal();

  static OrderList? get instance {
    _instance ??= OrderList._internal();
    return _instance;
  }

  final List<Order> _orders = [];

  List<Order> get orders => [..._orders];

  int get orderCount => _orders.length;

  void addOrder(Cart cart) {
    _orders.insert(
      0,
      Order(
        id: Uuid().v4(),
        total: cart.totalAmount,
        products: cart.items.values.toList(),
        date: DateTime.now(),
      ),
    );
    notifyListeners();
  }

  void removeOrder(Order order) {
    _orders.remove(order);
    notifyListeners();
  }

  void clearOrders() {
    _orders.clear();
    notifyListeners();
  }
}
