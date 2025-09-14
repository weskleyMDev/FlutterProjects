import 'package:admin_fribe/models/product_model.dart';
import 'package:equatable/equatable.dart';

class CartProduct extends Equatable {
  final ProductModel product;
  final String quantity;
  final String subtotal;

  const CartProduct({
    required this.product,
    required this.quantity,
    required this.subtotal,
  });

  factory CartProduct.empty() {
    return CartProduct(
      product: ProductModel.empty(),
      quantity: '0',
      subtotal: '0',
    );
  }

  CartProduct copyWith({
    ProductModel Function()? product,
    String Function()? quantity,
    String Function()? subtotal,
  }) {
    return CartProduct(
      product: product?.call() ?? this.product,
      quantity: quantity?.call() ?? this.quantity,
      subtotal: subtotal?.call() ?? this.subtotal,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [product, quantity, subtotal];
}
