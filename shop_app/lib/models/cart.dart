import 'dart:math';

import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';

import 'cart_item.dart';
import 'product.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => Map.unmodifiable(_items);

  int get itemCount => _items.length;

  String get totalAmount {
    return _items.values
        .fold(
          Decimal.zero,
          (sum, item) =>
              sum + Decimal.parse(item.price) * Decimal.parse(item.quantity),
        )
        .toStringAsFixed(2);
  }

  String getItemSubtotal(String id) {
    if (!_items.containsKey(id)) {
      return 'R\$ 0,00';
    } else {
      final item = _items[id]!;
      return (Decimal.parse(item.price) * Decimal.parse(item.quantity))
          .toStringAsFixed(2);
    }
  }

  void addItem(Product product) {
    if (_items.containsKey(product.id)) {
      _items.update(
        product.id,
        (existingItem) => existingItem.copyWith(
          quantity: (Decimal.parse(existingItem.quantity) + Decimal.one)
              .toString(),
        ),
      );
    } else {
      _items.putIfAbsent(
        product.id,
        () => CartItem(
          id: Random().nextInt(99).toString(),
          productId: product.id,
          name: product.title,
          quantity: '1',
          price: product.price,
        ),
      );
    }
    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void removeSingleItem(String id) {
    if (_items.containsKey(id)) {
      final existingItem = _items[id]!;
      if (Decimal.parse(existingItem.quantity) > Decimal.one) {
        _items.update(
          id,
          (existingItem) => existingItem.copyWith(
            quantity: (Decimal.parse(existingItem.quantity) - Decimal.one)
                .toString(),
          ),
        );
      } else {
        _items.remove(id);
      }
    }
    notifyListeners();
  }

  void clear() {
    _items.clear();
    notifyListeners();
  }
}
