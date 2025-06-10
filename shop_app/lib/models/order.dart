// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart_item.dart';

class Order {
  final String id;
  final String total;
  final List<CartItem> products;
  final DateTime date;

  Order({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });

  Order copyWith({
    String? id,
    String? total,
    List<CartItem>? products,
    DateTime? date,
  }) {
    return Order(
      id: id ?? this.id,
      total: total ?? this.total,
      products: products ?? this.products,
      date: date ?? this.date,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'products': products.map((x) => x.toMap()).toList(),
      'date': date.toIso8601String(),
    };
  }

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'] as String,
      total: map['total'] as String,
      products: List<CartItem>.from(
        (map['products'] as List<dynamic>).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      date: DateTime.parse(map['date'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Order.fromJson(String source) =>
      Order.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Order(id: $id, total: $total, products: $products, date: $date)';
  }

  @override
  bool operator ==(covariant Order other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.total == total &&
        listEquals(other.products, products) &&
        other.date == date;
  }

  @override
  int get hashCode {
    return id.hashCode ^ total.hashCode ^ products.hashCode ^ date.hashCode;
  }
}
