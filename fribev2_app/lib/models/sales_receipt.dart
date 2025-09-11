import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart_item.dart';
import 'payment.dart';

class SalesReceipt {
  final String id;
  final String total;
  final List<CartItem> cart;
  final DateTime createAt;
  final List<Payment> payments;
  final String discount;
  final String shipping;
  final String discountReason;

  SalesReceipt({
    required this.id,
    required this.total,
    required this.cart,
    required this.createAt,
    required this.payments,
    required this.discount,
    required this.shipping,
    this.discountReason = '',
  });

  SalesReceipt copyWith({
    String? id,
    String? total,
    List<CartItem>? cart,
    DateTime? createAt,
    List<Payment>? payments,
    String? discount,
    String? shipping,
    String? discountReason,
  }) {
    return SalesReceipt(
      id: id ?? this.id,
      total: total ?? this.total,
      cart: cart ?? this.cart,
      createAt: createAt ?? this.createAt,
      payments: payments ?? this.payments,
      discount: discount ?? this.discount,
      shipping: shipping ?? this.shipping,
      discountReason: discountReason ?? this.discountReason,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'total': total,
      'cart': cart.map((x) => x.toMap()).toList(),
      'createAt': createAt.toIso8601String(),
      'payments': payments.map((x) => x.toMap()).toList(),
      'discount': discount,
      'shipping': shipping,
      'discountReason': discountReason,
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
      payments: List<Payment>.from(
        (map['payments'] as List<dynamic>)
            .whereType<Map<String, dynamic>>()
            .map<Payment>((x) => Payment.fromMap(x)),
      ),
      discount: map['discount'] as String,
      shipping: map['shipping'] as String,
      discountReason: map['discountReason'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesReceipt.fromJson(String source, String sid) =>
      SalesReceipt.fromMap(json.decode(source) as Map<String, dynamic>, sid);

  @override
  String toString() {
    return 'SalesReceipt(id: $id, total: $total, cart: $cart, createAt: $createAt, payments: $payments, discount: $discount, shipping: $shipping, discountReason: $discountReason)';
  }

  @override
  bool operator ==(covariant SalesReceipt other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.total == total &&
        listEquals(other.cart, cart) &&
        other.createAt == createAt &&
        listEquals(other.payments, payments) &&
        other.discount == discount &&
        other.shipping == shipping &&
        other.discountReason == discountReason;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        total.hashCode ^
        cart.hashCode ^
        createAt.hashCode ^
        payments.hashCode ^
        discount.hashCode ^
        shipping.hashCode ^
        discountReason.hashCode;
  }
}
