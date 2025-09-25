import 'package:equatable/equatable.dart';

final class ProductModel extends Equatable {
  final String id;
  final String name;
  final String amount;
  final String category;
  final String imageUrl;
  final String measure;
  final String price;

  const ProductModel._({
    this.id = '',
    this.name = '',
    this.amount = '',
    this.category = '',
    this.imageUrl = '',
    this.measure = '',
    this.price = '',
  });

  const ProductModel.empty() : this._();

  ProductModel copyWith({
    String Function()? id,
    String Function()? name,
    String Function()? amount,
    String Function()? category,
    String Function()? imageUrl,
    String Function()? measure,
    String Function()? price,
  }) {
    return ProductModel._(
      id: id?.call() ?? this.id,
      name: name?.call() ?? this.name,
      amount: amount?.call() ?? this.amount,
      category: category?.call() ?? this.category,
      imageUrl: imageUrl?.call() ?? this.imageUrl,
      measure: measure?.call() ?? this.measure,
      price: price?.call() ?? this.price,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'amount': amount,
    'category': category,
    'imageUrl': imageUrl,
    'measure': measure,
    'price': price,
  };

  factory ProductModel.fromMap(Map<String, dynamic> map) => ProductModel._(
    id: map['id'] ?? '',
    name: map['name'] ?? '',
    amount: map['amount'] ?? '',
    category: map['category'] ?? '',
    imageUrl: map['imageUrl'] ?? '',
    measure: map['measure'] ?? '',
    price: map['price'] ?? '',
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    id,
    name,
    amount,
    category,
    imageUrl,
    measure,
    price,
  ];
}
