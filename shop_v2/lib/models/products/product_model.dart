import 'dart:convert';

import 'package:flutter/foundation.dart';

class ProductModel {
  final String id;
  final String price;
  final Map<String, String> title;
  final List<String> images;
  final List<String> sizes;

  ProductModel({
    required this.id,
    required this.price,
    required this.title,
    required this.images,
    required this.sizes,
  });

  ProductModel.fromCart({
    required this.id,
    required this.price,
    required this.title,
    this.images = const [],
    this.sizes = const [],
  });

  ProductModel copyWith({
    String? id,
    String? price,
    Map<String, String>? title,
    List<String>? images,
    List<String>? sizes,
  }) {
    return ProductModel(
      id: id ?? this.id,
      price: price ?? this.price,
      title: title ?? this.title,
      images: images ?? this.images,
      sizes: sizes ?? this.sizes,
    );
  }

  Map<String, dynamic> toCartMap() => <String, dynamic>{
    'id': id,
    'title': title,
    'price': price,
  };

  factory ProductModel.fromCartMap(Map map) {
    return ProductModel.fromCart(
      id: map['id'] as String,
      price: map['price'] as String,
      title: Map<String, String>.from((map['title'] as Map)),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'price': price,
      'title': title,
      'images': images,
      'sizes': sizes,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      price: map['price'] as String,
      title: Map<String, String>.from((map['title'] as Map)),
      images: List<String>.from((map['images'] as List)),
      sizes: List<String>.from((map['sizes'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ProductModel(id: $id, price: $price, title: $title, images: $images, sizes: $sizes)';
  }

  @override
  bool operator ==(covariant ProductModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.price == price &&
        mapEquals(other.title, title) &&
        listEquals(other.images, images) &&
        listEquals(other.sizes, sizes);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        price.hashCode ^
        title.hashCode ^
        images.hashCode ^
        sizes.hashCode;
  }
}
