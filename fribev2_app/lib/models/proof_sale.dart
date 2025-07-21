// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

import 'cart_item.dart';

class ProofSale {
  final String id;
  final String amount;
  final String subtotal;
  final String total;
  final List<CartItem> cart;
  final DateTime createAt;

  ProofSale({
    required this.id,
    required this.amount,
    required this.subtotal,
    required this.total,
    required this.cart,
    required this.createAt,
  });

  ProofSale copyWith({
    String? id,
    String? amount,
    String? subtotal,
    String? total,
    List<CartItem>? cart,
    DateTime? createAt,
  }) {
    return ProofSale(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      subtotal: subtotal ?? this.subtotal,
      total: total ?? this.total,
      cart: cart ?? this.cart,
      createAt: createAt ?? this.createAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'amount': amount,
      'subtotal': subtotal,
      'total': total,
      'cart': cart.map((x) => x.toMap()).toList(),
      'createAt': createAt.toIso8601String(),
    };
  }

  factory ProofSale.fromMap(Map<String, dynamic> map, String pid) {
    return ProofSale(
      id: pid,
      amount: map['amount'] as String,
      subtotal: map['subtotal'] as String,
      total: map['total'] as String,
      cart: List<CartItem>.from(
        (map['cart'] as List<int>).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createAt: DateTime.parse(map['createAt'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProofSale.fromJson(String source, String pid) =>
      ProofSale.fromMap(json.decode(source) as Map<String, dynamic>, pid);

  @override
  String toString() {
    return 'ProofSale(id: $id, amount: $amount, subtotal: $subtotal, total: $total, cart: $cart, createAt: $createAt)';
  }

  @override
  bool operator ==(covariant ProofSale other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.amount == amount &&
        other.subtotal == subtotal &&
        other.total == total &&
        listEquals(other.cart, cart) &&
        other.createAt == createAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        amount.hashCode ^
        subtotal.hashCode ^
        total.hashCode ^
        cart.hashCode ^
        createAt.hashCode;
  }
}
