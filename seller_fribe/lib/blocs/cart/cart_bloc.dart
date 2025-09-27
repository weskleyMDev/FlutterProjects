import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:seller_fribe/blocs/cart/validator/discount_input.dart';
import 'package:seller_fribe/blocs/cart/validator/discount_reason_input.dart';
import 'package:seller_fribe/blocs/cart/validator/quantity_input.dart';
import 'package:seller_fribe/blocs/cart/validator/shipping_input.dart';
import 'package:seller_fribe/models/cart_item_model.dart';
import 'package:seller_fribe/models/product_model.dart';
import 'package:uuid/uuid.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState.initial()) {
    on<CartProductQuantityChanged>(_onQuantityChanged);
    on<CartDiscountChanged>(_onDiscountChanged);
    on<CartShippingChanged>(_onShippingChanged);
    on<SaveCartItem>(_onSaveCartItem);
    on<ClearQuantityInput>(_onClearQuantityInput);
    on<RemoveItemFromCart>(_onRemoveItem);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
  }

  void _onQuantityChanged(
    CartProductQuantityChanged event,
    Emitter<CartState> emit,
  ) {
    final input = QuantityInput.dirty(event.quantity);
    emit(state.copyWith(quantityInput: () => input));
  }

  void _onDiscountChanged(
    CartDiscountChanged event,
    Emitter<CartState> emit,
  ) {
    final input = DiscountInput.dirty(event.discount);
    emit(state.copyWith(discountInput: () => input));
  }

  void _onShippingChanged(
    CartShippingChanged event,
    Emitter<CartState> emit,
  ) {
    final input = ShippingInput.dirty(event.shipping);
    emit(state.copyWith(shippingInput: () => input));
  }

  void _onSaveCartItem(SaveCartItem event, Emitter<CartState> emit) {
    final existingIndex = state.cartItems.indexWhere(
      (item) => item.productId == event.product.id,
    );
    final quantity = Decimal.parse(state.quantityInput.value);
    final price = Decimal.parse(event.product.price);
    final subtotal = (price * quantity).toDouble();
    List<CartItemModel> updatedItems = List.from(state.cartItems);
    if (existingIndex != -1) {
      final existingItem = updatedItems[existingIndex];
      final newSubtotal = (price * quantity).toDouble();
      updatedItems[existingIndex] = existingItem.copyWith(
        quantity: () => quantity.toDouble(),
        subtotal: () => newSubtotal,
      );
    } else {
      final newItem = CartItemModel.empty().copyWith(
        id: () => const Uuid().v4(),
        productId: () => event.product.id,
        quantity: () => quantity.toDouble(),
        subtotal: () => subtotal,
      );
      updatedItems.add(newItem);
    }
    emit(
      state.copyWith(
        cartItems: () => updatedItems,
        quantityInput: () => const QuantityInput.pure(),
        submissionStatus: () => FormzSubmissionStatus.success,
      ),
    );
  }

  void _onClearQuantityInput(
    ClearQuantityInput event,
    Emitter<CartState> emit,
  ) {
    emit(
      state.copyWith(
        quantityInput: () => const QuantityInput.pure(),
        submissionStatus: () => FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onRemoveItem(RemoveItemFromCart event, Emitter<CartState> emit) {
    final updatedItems = state.cartItems
        .where((item) => item.productId != event.productId)
        .toList();

    emit(state.copyWith(cartItems: () => updatedItems));
  }

  void _onUpdateItemQuantity(
    UpdateItemQuantity event,
    Emitter<CartState> emit,
  ) {
    final updatedItems = List<CartItemModel>.from(state.cartItems);
    final index = updatedItems.indexWhere(
      (item) => item.productId == event.productId,
    );

    if (index != -1) {
      final item = updatedItems[index];
      final newSubtotal = item.subtotal / item.quantity * event.newQuantity;

      updatedItems[index] = item.copyWith(
        quantity: () => event.newQuantity,
        subtotal: () => newSubtotal.toDouble(),
      );

      emit(state.copyWith(cartItems: () => updatedItems));
    }
  }

  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    emit(state.copyWith(cartItems: () => []));
  }
}
