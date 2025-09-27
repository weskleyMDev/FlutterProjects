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

final class OnPaymentMethodChanged extends CartEvent {
  const OnPaymentMethodChanged(this.method);

  final PaymentsMethod method;

  @override
  List<Object> get props => [method];
}

final class PaymentInputChanged extends CartEvent {
  const PaymentInputChanged(this.value);

  final String value;

  @override
  List<Object> get props => [value];
}

final class SavePaymentMethod extends CartEvent {
  const SavePaymentMethod(this.payment);

  final PaymentModel payment;

  @override
  List<Object> get props => [payment];
}

final class RemovePaymentMethod extends CartEvent {
  final int index;
  const RemovePaymentMethod(this.index);

  @override
  List<Object> get props => [index];
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