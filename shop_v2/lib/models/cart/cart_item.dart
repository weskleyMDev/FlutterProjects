import 'dart:convert';

import 'package:shop_v2/models/products/product_model.dart';

class CartItem {
  final String? id;
  final String? category;
  final int? quantity;
  final String? size;
  final ProductModel? product;

  CartItem({
    required this.id,
    required this.category,
    required this.quantity,
    required this.size,
    required this.product,
  });

  CartItem copyWith({
    String? id,
    String? category,
    int? quantity,
    String? size,
    ProductModel? product,
  }) {
    return CartItem(
      id: id ?? this.id,
      category: category ?? this.category,
      quantity: quantity ?? this.quantity,
      size: size ?? this.size,
      product: product ?? this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'category': category,
      'quantity': quantity,
      'size': size,
      'product': product?.toCartMap(),
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String?,
      category: map['category'] as String?,
      quantity: map['quantity'] as int?,
      size: map['size'] as String?,
      product: map['product'] == null
          ? null
          : ProductModel.fromMap(map['product'] as Map<String, dynamic>),
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, category: $category, quantity: $quantity, size: $size, product: $product)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.category == category &&
        other.quantity == quantity &&
        other.size == size &&
        other.product == product;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        category.hashCode ^
        quantity.hashCode ^
        size.hashCode ^
        product.hashCode;
  }
}
