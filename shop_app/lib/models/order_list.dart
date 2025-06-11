import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart';

import '../exceptions/http_exception.dart';
import 'cart.dart';
import 'order.dart';

class OrderList with ChangeNotifier {
  static OrderList? _instance;

  OrderList._internal();

  static OrderList? get instance {
    _instance ??= OrderList._internal();
    return _instance;
  }

  final List<Order> _orders = [];
  final url = Uri.parse(dotenv.get('firebase_url', fallback: ''));

  List<Order> get orders => [..._orders];

  int get orderCount => _orders.length;

  Future<void> loadOrders() async {
    try {
      final response = await get(
        url.replace(path: 'orders.json'),
        headers: {'Content-Type': 'application/json'},
      );
      if (response.body == 'null') return;
      if (response.statusCode >= 400) {
        throw HttpException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }
      final Map<String, dynamic> data = jsonDecode(response.body);
      _orders.clear();
      if (data.isEmpty) {
        return;
      }
      data.forEach((id, productData) {
        final order = Order.fromMap({'id': id, ...productData});
        _orders.insert(0, order);
      });
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> addOrder(Cart cart) async {
    final order = Order(
      id: '',
      total: cart.totalAmount,
      products: cart.items.values.toList(),
      date: DateTime.now(),
    );

    try {
      final response = await post(
        url.replace(path: 'orders.json'),
        headers: {'Content-Type': 'application/json'},
        body: order.toJson(),
      );

      if (response.statusCode >= 400) {
        throw HttpException(
          statusCode: response.statusCode,
          message: response.body,
        );
      }

      final firebaseId = jsonDecode(response.body)['name'];
      _orders.insert(0, order.copyWith(id: firebaseId));
      notifyListeners();
    } catch (e) {
      rethrow;
    }
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
