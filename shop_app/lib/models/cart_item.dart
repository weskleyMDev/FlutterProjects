// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class CartItem {
  final String id;
  final String productId;
  final String title;
  final String quantity;
  final String price;

  CartItem({
    required this.id,
    required this.productId,
    required this.title,
    required this.quantity,
    required this.price,
  });

  CartItem copyWith({
    String? id,
    String? productId,
    String? title,
    String? quantity,
    String? price,
  }) {
    return CartItem(
      id: id ?? this.id,
      productId: productId ?? this.productId,
      title: title ?? this.title,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'productId': productId,
      'title': title,
      'quantity': quantity,
      'price': price,
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      id: map['id'] as String,
      productId: map['productId'] as String,
      title: map['title'] as String,
      quantity: map['quantity'] as String,
      price: map['price'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory CartItem.fromJson(String source) => CartItem.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'CartItem(id: $id, productId: $productId, title: $title, quantity: $quantity, price: $price)';
  }

  @override
  bool operator ==(covariant CartItem other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.productId == productId &&
      other.title == title &&
      other.quantity == quantity &&
      other.price == price;
  }

  @override
  int get hashCode {
    return id.hashCode ^
      productId.hashCode ^
      title.hashCode ^
      quantity.hashCode ^
      price.hashCode;
  }
}
