// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart_item.dart';

class SalesReceipt {
  final String id;
  final String total;
  final List<CartItem> cart;
  final DateTime createAt;
  final Map<String, String> payments;

  SalesReceipt({
    required this.id,
    required this.total,
    required this.cart,
    required this.createAt,
    required this.payments,
  });

  SalesReceipt copyWith({
    String? id,
    String? total,
    List<CartItem>? cart,
    DateTime? createAt,
    Map<String, String>? payments,
  }) {
    return SalesReceipt(
      id: id ?? this.id,
      total: total ?? this.total,
      cart: cart ?? this.cart,
      createAt: createAt ?? this.createAt,
      payments: payments ?? this.payments,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'cart': cart.map((x) => x.toMap()).toList(),
      'createAt': createAt.toIso8601String(),
      'payments': payments,
    };
  }

  factory SalesReceipt.fromMap(Map<String, dynamic> map, String sid) {
    return SalesReceipt(
      id: sid,
      total: map['total'] as String,
      cart: List<CartItem>.from(
        (map['cart'] as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map<CartItem>((x) => CartItem.fromMap(x)),
      ),
      createAt: DateTime.parse(map['createAt'] as String),
      payments: Map<String, String>.from(
        (map['payments'] as Map<String, String>),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesReceipt.fromJson(String source, String sid) =>
      SalesReceipt.fromMap(json.decode(source) as Map<String, dynamic>, sid);

  @override
  String toString() {
    return 'SalesReceipt(id: $id, total: $total, cart: $cart, createAt: $createAt, payments: $payments)';
  }

  @override
  bool operator ==(covariant SalesReceipt other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.total == total &&
        listEquals(other.cart, cart) &&
        other.createAt == createAt &&
        mapEquals(other.payments, payments);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        total.hashCode ^
        cart.hashCode ^
        createAt.hashCode ^
        payments.hashCode;
  }
}
