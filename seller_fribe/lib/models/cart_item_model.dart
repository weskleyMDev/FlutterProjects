import 'package:equatable/equatable.dart';

final class CartItemModel extends Equatable {
  final String id;
  final String productId;
  final num quantity;
  final num subtotal;

  const CartItemModel._({
    this.id = '',
    this.productId = '',
    this.quantity = 0,
    this.subtotal = 0,
  });

  const CartItemModel.empty() : this._();

  CartItemModel copyWith({
    String Function()? id,
    String Function()? productId,
    num Function()? quantity,
    num Function()? subtotal,
  }) {
    return CartItemModel._(
      id: id?.call() ?? this.id,
      productId: productId?.call() ?? this.productId,
      quantity: quantity?.call() ?? this.quantity,
      subtotal: subtotal?.call() ?? this.subtotal,
    );
  }

  Map<String, dynamic> toMap() => {
    'id': id,
    'productId': productId,
    'quantity': quantity,
    'subtotal': subtotal,
  };

  factory CartItemModel.fromMap(Map<String, dynamic> map) => CartItemModel._(
    id: map['id'] ?? '',
    productId: map['productId'] ?? '',
    quantity: map['quantity'] ?? 0,
    subtotal: map['subtotal'] ?? 0,
  );

  @override
  List<Object?> get props => [id, productId, quantity, subtotal];
}
