part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

final class LoadProductsStream extends ProductEvent {
  const LoadProductsStream();

  @override
  List<Object> get props => [];
}

final class GetProductById extends ProductEvent {
  final List<CartItem> cartItem;
  final String id;

  const GetProductById(this.id, this.cartItem);

  @override
  List<Object> get props => [id, cartItem];
}
