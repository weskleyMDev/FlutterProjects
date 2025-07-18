import 'dart:convert';

class Product {
  final String id;
  final String name;
  final String category;
  final String measure;
  final String amount;
  final String price;
  final String? imageUrl;

  Product({
    this.id = '',
    required this.name,
    required this.category,
    required this.measure,
    required this.amount,
    required this.price,
    this.imageUrl = '',
  });

  Product copyWith({
    String? id,
    String? name,
    String? category,
    String? measure,
    String? amount,
    String? price,
    String? imageUrl,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      category: category ?? this.category,
      measure: measure ?? this.measure,
      amount: amount ?? this.amount,
      price: price ?? this.price,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'category': category,
      'measure': measure,
      'amount': amount,
      'price': price,
      'imageUrl': imageUrl,
    };
  }

  factory Product.fromMap(Map<String, dynamic> map, String pid) {
    return Product(
      id: pid,
      name: map['name'] as String,
      category: map['category'] as String,
      measure: map['measure'] as String,
      amount: map['amount'] as String,
      price: map['price'] as String,
      imageUrl: map['imageUrl'] != null ? map['imageUrl'] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source, String pid) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>, pid);

  @override
  String toString() {
    return 'Product(id: $id, name: $name, category: $category, measure: $measure, amount: $amount, price: $price, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(covariant Product other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.name == name &&
        other.category == category &&
        other.measure == measure &&
        other.amount == amount &&
        other.price == price &&
        other.imageUrl == imageUrl;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        category.hashCode ^
        measure.hashCode ^
        amount.hashCode ^
        price.hashCode ^
        imageUrl.hashCode;
  }
}
