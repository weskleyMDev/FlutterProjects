import 'dart:convert';

import 'package:equatable/equatable.dart';

final class ProductModel extends Equatable {
  final String id;
  final num price;
  final Map<String, String> title;
  final List<String> images;
  final List<String> sizes;

  const ProductModel._({
    required this.id,
    required this.price,
    required this.title,
    required this.images,
    required this.sizes,
  });

  factory ProductModel.empty() => const ProductModel._(
    id: '',
    price: 0.0,
    title: {},
    images: [],
    sizes: [],
  );

  ProductModel copyWith({
    String Function()? id,
    num Function()? price,
    Map<String, String> Function()? title,
    List<String> Function()? images,
    List<String> Function()? sizes,
  }) {
    return ProductModel._(
      id: id != null ? id() : this.id,
      price: price != null ? price() : this.price,
      title: title != null ? title() : this.title,
      images: images != null ? images() : this.images,
      sizes: sizes != null ? sizes() : this.sizes,
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
    return ProductModel._(
      id: map['id'] as String,
      price: map['price'] as num,
      title: Map<String, String>.from((map['title'] as Map<String, dynamic>)),
      images: List<String>.from((map['images'] as List)),
      sizes: List<String>.from((map['sizes'] as List)),
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, price, title, images, sizes];
  }
}
