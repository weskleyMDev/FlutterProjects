import 'dart:convert';

import 'package:shop_v2/models/products/product_model.dart';

class ProductOrder {
  final ProductModel product;
  final int quantity;
  final String size;

  ProductOrder({
    required this.product,
    required this.quantity,
    required this.size,
  });

  ProductOrder copyWith({ProductModel? product, int? quantity, String? size}) {
    return ProductOrder(
      product: product ?? this.product,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'product': product.toMap(),
      'quantity': quantity,
      'size': size,
    };
  }

  factory ProductOrder.fromMap(Map<String, dynamic> map) {
    return ProductOrder(
      product: ProductModel.fromMap(map['product'] as Map<String, dynamic>),
      quantity: map['quantity'] as int,
      size: map['size'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductOrder.fromJson(String source) =>
      ProductOrder.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ProductOrder(product: $product, quantity: $quantity, size: $size)';

  @override
  bool operator ==(covariant ProductOrder other) {
    if (identical(this, other)) return true;

    return other.product == product &&
        other.quantity == quantity &&
        other.size == size;
  }

  @override
  int get hashCode => product.hashCode ^ quantity.hashCode ^ size.hashCode;
}
