import 'dart:convert';

import 'package:shop_v2/models/products/product_model.dart';

class CartItem {
  final String id;
  final String category;
  final int quantity;
  final String size;
  final ProductModel product;
  final String userId;

  CartItem({
    required this.id,
    required this.category,
    required this.quantity,
    required this.size,
    required this.product,
    required this.userId,
  });

  CartItem copyWith({
    String? id,
    String? category,
    int? quantity,
    String? size,
    ProductModel? product,
    String? userId,
  }) {
    return CartItem(
      id: id ?? this.id,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      product: product ?? this.product,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'quantity': quantity,
      'size': size,
      'product': product.toCartMap(),
      'userId': userId,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      category: map['category'] as String,
      quantity: map['quantity'] as int,
      size: map['size'] as String,
      product: ProductModel.fromCartMap(map['product'] as Map),
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, category: $category, quantity: $quantity, size: $size, product: $product), userId: $userId)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.quantity == quantity &&
        other.size == size &&
        other.product == product &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        product.hashCode ^
        userId.hashCode;
  }
}
