part of 'cart_bloc.dart';

sealed class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

final class CartProductQuantityChanged extends CartEvent {
  const CartProductQuantityChanged(this.quantity);

  final String quantity;

  @override
  List<Object> get props => [quantity];
}

final class CartDiscountChanged extends CartEvent {
  const CartDiscountChanged(this.discount);

  final String discount;

  @override
  List<Object> get props => [discount];
}

final class CartShippingChanged extends CartEvent {
  const CartShippingChanged(this.shipping);

  final String shipping;

  @override
  List<Object> get props => [shipping];
}

final class ClearQuantityInput extends CartEvent {
  const ClearQuantityInput();
}

final class SaveCartItem extends CartEvent {
  const SaveCartItem(this.product);

  final ProductModel product;

  @override
  List<Object> get props => [product];
}

final class RemoveItemFromCart extends CartEvent {
  const RemoveItemFromCart(this.productId);

  final String productId;

  @override
  List<Object> get props => [productId];
}

final class UpdateItemQuantity extends CartEvent {
  const UpdateItemQuantity(this.productId, this.newQuantity);

  final String productId;
  final double newQuantity;

  @override
  List<Object> get props => [productId, newQuantity];
}

final class ClearCart extends CartEvent {
  const ClearCart();
}