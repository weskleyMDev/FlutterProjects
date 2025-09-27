import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:seller_fribe/blocs/cart/validator/discount_input.dart';
import 'package:seller_fribe/blocs/cart/validator/discount_reason_input.dart';
import 'package:seller_fribe/blocs/cart/validator/payment_input.dart';
import 'package:seller_fribe/blocs/cart/validator/quantity_input.dart';
import 'package:seller_fribe/blocs/cart/validator/shipping_input.dart';
import 'package:seller_fribe/models/cart_item_model.dart';
import 'package:seller_fribe/models/payment_model.dart';
import 'package:seller_fribe/models/product_model.dart';
import 'package:uuid/uuid.dart';

part 'cart_event.dart';
part 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState.initial()) {
    on<CartProductQuantityChanged>(_onQuantityChanged);
    on<CartDiscountChanged>(_onDiscountChanged);
    on<CartDiscountReasonChanged>(_onDiscountReasonChanged);
    on<ClearDiscountReasonInput>(_onClearDiscountReasonInput);
    on<CartShippingChanged>(_onShippingChanged);
    on<SaveCartItem>(_onSaveCartItem);
    on<ClearQuantityInput>(_onClearQuantityInput);
    on<RemoveItemFromCart>(_onRemoveItem);
    on<UpdateItemQuantity>(_onUpdateItemQuantity);
    on<ClearCart>(_onClearCart);
    on<SavePaymentMethod>(_onSavePaymentMethod);
    on<RemovePaymentMethod>(_onRemovePaymentMethod);
    on<OnPaymentMethodChanged>(_onPaymentMethodChanged);
    on<PaymentInputChanged>(_onPaymentInputChanged);
    on<ClearPaymentMethod>(_onClearPaymentMethod);
    on<ClearPayments>(_onClearPayments);
  }

  void _onQuantityChanged(
    CartProductQuantityChanged event,
    Emitter<CartState> emit,
  ) {
    final input = QuantityInput.dirty(event.quantity);
    emit(state.copyWith(quantityInput: () => input));
  }

  void _onDiscountChanged(CartDiscountChanged event, Emitter<CartState> emit) {
    final discountInput = DiscountInput.dirty(event.discount.trim());

    final discountValue = discountInput.value.replaceAll(',', '.');

    final hasDiscount =
        discountValue.isNotEmpty &&
        Decimal.tryParse(discountValue) != Decimal.zero;

    final updatedReasonInput = hasDiscount
        ? (state.discountReasonInput.isPure
              ? DiscountReasonInput.dirty(state.discountReasonInput.value)
              : state.discountReasonInput)
        : const DiscountReasonInput.pure();

    emit(
      state.copyWith(
        payments: () => [],
        discountInput: () => discountInput,
        discountReasonInput: () => updatedReasonInput,
      ),
    );
  }

  void _onDiscountReasonChanged(
    CartDiscountReasonChanged event,
    Emitter<CartState> emit,
  ) {
    final input = DiscountReasonInput.dirty(event.reason);
    emit(state.copyWith(discountReasonInput: () => input));
  }

  void _onClearDiscountReasonInput(
    ClearDiscountReasonInput event,
    Emitter<CartState> emit,
  ) {
    emit(
      state.copyWith(
        discountReasonInput: () => const DiscountReasonInput.pure(),
        submissionStatus: () => FormzSubmissionStatus.initial,
      ),
    );
  }

  void _onShippingChanged(CartShippingChanged event, Emitter<CartState> emit) {
    final input = ShippingInput.dirty(event.shipping);
    emit(state.copyWith(payments: () => [], shippingInput: () => input));
  }

  void _onPaymentMethodChanged(
    OnPaymentMethodChanged event,
    Emitter<CartState> emit,
  ) {
    emit(state.copyWith(selectedPaymentMethod: () => event.method));
  }

  void _onPaymentInputChanged(
    PaymentInputChanged event,
    Emitter<CartState> emit,
  ) {
    final input = PaymentInput.dirty(event.value);
    emit(state.copyWith(paymentInput: () => input));
  }

  void _onClearPaymentMethod(
    ClearPaymentMethod event,
    Emitter<CartState> emit,
  ) {
    emit(
      state.copyWith(
        selectedPaymentMethod: () => PaymentsMethod.dinheiro,
        paymentInput: () => const PaymentInput.pure(),
        submissionStatus: () => FormzSubmissionStatus.initial,
      ),
    );
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
    final updatedItems = List<CartItemModel>.from(state.cartItems)
      ..removeWhere((item) => item.productId == event.productId);

    if (updatedItems.isEmpty) {
      emit(CartState.initial());
    } else {
      emit(state.copyWith(cartItems: () => updatedItems));
    }
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
    emit(CartState.initial());
  }

  void _onSavePaymentMethod(SavePaymentMethod event, Emitter<CartState> emit) {
    emit(
      state.copyWith(submissionStatus: () => FormzSubmissionStatus.inProgress),
    );
    try {
      final updatedPayments = List<PaymentModel>.from(state.payments);
      final newPayment = PaymentModel.empty().copyWith(
        method: () => event.method,
        amount: () => event.amount,
      );
      updatedPayments.add(newPayment);
      emit(
        state.copyWith(
          payments: () => updatedPayments,
          submissionStatus: () => FormzSubmissionStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: () => FormzSubmissionStatus.failure,
          errorMessage: () => 'Erro ao adicionar método de pagamento: $e',
        ),
      );
    }
  }

  void _onRemovePaymentMethod(
    RemovePaymentMethod event,
    Emitter<CartState> emit,
  ) {
    try {
      final updatedPayments = List<PaymentModel>.from(state.payments);
      if (event.index >= 0 && event.index < updatedPayments.length) {
        updatedPayments.removeAt(event.index);
        emit(state.copyWith(payments: () => updatedPayments));
      }
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: () => FormzSubmissionStatus.failure,
          errorMessage: () => 'Erro ao remover método de pagamento: $e',
        ),
      );
    }
  }

  void _onClearPayments(ClearPayments event, Emitter<CartState> emit) {
    emit(state.copyWith(payments: () => []));
  }
}
