import 'dart:convert';

import 'package:equatable/equatable.dart';

final class ProductModel extends Equatable {
  final String id;
  final String amount;
  final String category;
  final String imageUrl;
  final String measure;
  final String name;
  final String price;

  const ProductModel._({
    required this.id,
    required this.amount,
    required this.category,
    required this.imageUrl,
    required this.measure,
    required this.name,
    required this.price,
  });

  factory ProductModel.empty() => const ProductModel._(
    id: '',
    amount: '',
    category: '',
    imageUrl: '',
    measure: '',
    name: '',
    price: '',
  );

  ProductModel copyWith({
    String Function()? id,
    String Function()? amount,
    String Function()? category,
    String Function()? imageUrl,
    String Function()? measure,
    String Function()? name,
    String Function()? price,
  }) {
    return ProductModel._(
      id: id?.call() ?? this.id,
      amount: amount?.call() ?? this.amount,
      category: category?.call() ?? this.category,
      imageUrl: imageUrl?.call() ?? this.imageUrl,
      measure: measure?.call() ?? this.measure,
      name: name?.call() ?? this.name,
      price: price?.call() ?? this.price,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'amount': amount,
      'category': category,
      'imageUrl': imageUrl,
      'measure': measure,
      'name': name,
      'price': price,
    };
  }

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel._(
      id: map['id'] as String? ?? '',
      amount: map['amount'] as String? ?? '',
      category: map['category'] as String? ?? '',
      imageUrl: map['imageUrl'] as String? ?? '',
      measure: map['measure'] as String? ?? '',
      name: map['name'] as String? ?? '',
      price: map['price'] as String? ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ProductModel.fromJson(String source) =>
      ProductModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [id, name, category, amount, price, measure, imageUrl];
  }
}
