import 'dart:convert';

import 'package:admin_shop/models/product_model.dart';
import 'package:equatable/equatable.dart';

final class CartItem extends Equatable {
  final String id;
  final int quantity;
  final String category;
  final String size;
  final String userId;
  final String productId;
  final ProductModel? product;

  const CartItem._({
    required this.id,
    required this.quantity,
    required this.category,
    required this.size,
    required this.userId,
    required this.productId,
    this.product,
  });

  factory CartItem.initial() => CartItem._(
    id: '',
    quantity: 0,
    category: '',
    size: '',
    userId: '',
    productId: '',
    product: null,
  );

  CartItem copyWith({
    String Function()? id,
    int Function()? quantity,
    String Function()? category,
    String Function()? size,
    String Function()? userId,
    String Function()? productId,
    ProductModel? Function()? product,
  }) {
    return CartItem._(
      id: id != null ? id() : this.id,
      quantity: quantity != null ? quantity() : this.quantity,
      category: category != null ? category() : this.category,
      size: size != null ? size() : this.size,
      userId: userId != null ? userId() : this.userId,
      productId: productId != null ? productId() : this.productId,
      product: product != null ? product() : this.product,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'quantity': quantity,
      'category': category,
      'size': size,
      'userId': userId,
      'productId': productId,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem._(
      id: map['id'] as String,
      quantity: map['quantity'] as int,
      category: map['category'] as String,
      size: map['size'] as String,
      userId: map['userId'] as String,
      productId: map['productId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) =>
      CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, quantity, category, size, userId, productId, product];
  }
}
