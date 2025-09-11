import 'dart:convert';

import 'package:fribev2_app/models/product.dart';

class CartItem {
  final String id;
  final String productId;
  final num quantity;
  final num subtotal;
  final Product? product;

  CartItem({
    required this.id,
    required this.productId,
    required this.quantity,
    required this.subtotal,
    this.product,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    num? quantity,
    num? subtotal,
    Product? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
      product: product ?? this.product,
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
    return CartItem(
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
  String toString() {
    return 'CartItem(id: $id, productId: $productId, quantity: $quantity, subtotal: $subtotal, product: $product)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.productId == productId &&
        other.quantity == quantity &&
        other.subtotal == subtotal &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        productId.hashCode ^
        quantity.hashCode ^
        subtotal.hashCode ^
        product.hashCode;
  }
}
