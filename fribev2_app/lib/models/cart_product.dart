import 'dart:convert';

import 'package:fribev2_app/models/product.dart';

class CartProduct {
  final Product product;
  final num quantity;
  final num subtotal;

  CartProduct({
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  CartProduct copyWith({Product? product, num? quantity, num? subtotal}) {
    return CartProduct(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      subtotal: subtotal ?? this.subtotal,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }

  factory CartProduct.fromMap(Map<String, dynamic> map, String pid) {
    return CartProduct(
      product: Product.fromMap(map['product'] as Map<String, dynamic>, pid),
      quantity: map['quantity'] as num,
      subtotal: map['subtotal'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartProduct.fromJson(String source, String pid) =>
      CartProduct.fromMap(json.decode(source) as Map<String, dynamic>, pid);

  @override
  String toString() =>
      'CartProduct(product: $product, quantity: $quantity, subtotal: $subtotal)';

  @override
  bool operator ==(covariant CartProduct other) {
    if (identical(this, other)) return true;

    return other.product == product &&
        other.quantity == quantity &&
        other.subtotal == subtotal;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode ^ subtotal.hashCode;
}
