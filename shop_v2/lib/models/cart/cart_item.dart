import 'dart:convert';

import 'package:shop_v2/models/products/product_model.dart';

class CartItem {
  final String id;
  final int quantity;
  final String size;
  final String userId;
  final String productId;
  final ProductModel? product;

  CartItem({
    required this.id,
    required this.quantity,
    required this.size,
    required this.userId,
    required this.productId,
    this.product,
  });

  CartItem copyWith({
    String? id,
    int? quantity,
    String? size,
    String? userId,
    String? productId,
    ProductModel? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      userId: userId ?? this.userId,
      productId: productId ?? this.productId,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'size': size,
      'userId': userId,
      'productId': productId,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, quantity: $quantity, size: $size, product: $product), userId: $userId), productId: $productId)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.quantity == quantity &&
        other.size == size &&
        other.product == product &&
        other.userId == userId &&
        other.productId == productId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        product.hashCode ^
        userId.hashCode ^ 
        productId.hashCode;
  }
}
