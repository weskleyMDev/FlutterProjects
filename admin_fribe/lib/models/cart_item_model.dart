import 'dart:convert';

import 'package:equatable/equatable.dart';

final class CartItem extends Equatable {
  final String id;
  final String productId;
  final num quantity;
  final num subtotal;

  const CartItem._({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.subtotal,
  });

  factory CartItem.initial() =>
      const CartItem._(id: '', productId: '', quantity: 0, subtotal: 0);

  CartItem copyWith({
    String Function()? id,
    String Function()? productId,
    num Function()? quantity,
    num Function()? subtotal,
  }) {
    return CartItem._(
      id: id?.call() ?? this.id,
      productId: productId?.call() ?? this.productId,
      quantity: quantity?.call() ?? this.quantity,
      subtotal: subtotal?.call() ?? this.subtotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem._(
      id: map['id'] as String,
      productId: map['productId'] as String,
      quantity: map['quantity'] as num,
      subtotal: map['subtotal'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, productId, quantity, subtotal];
}
