part of 'cart_bloc.dart';

enum PaymentsMethod { dinheiro, credito, debito, pix, vale }

final class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final List<PaymentModel> payments;
  final PaymentsMethod selectedPaymentMethod;
  final QuantityInput quantityInput;
  final DiscountInput discountInput;
  final ShippingInput shippingInput;
  final PaymentInput paymentInput;
  final DiscountReasonInput discountReasonInput;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const CartState._({
    this.cartItems = const [],
    this.payments = const [],
    this.selectedPaymentMethod = PaymentsMethod.dinheiro,
    this.quantityInput = const QuantityInput.pure(),
    this.discountInput = const DiscountInput.pure(),
    this.shippingInput = const ShippingInput.pure(),
    this.discountReasonInput = const DiscountReasonInput.pure(),
    this.paymentInput = const PaymentInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  const CartState.initial() : this._();

  CartState copyWith({
    List<CartItemModel> Function()? cartItems,
    List<PaymentModel> Function()? payments,
    PaymentsMethod Function()? selectedPaymentMethod,
    QuantityInput Function()? quantityInput,
    DiscountInput Function()? discountInput,
    ShippingInput Function()? shippingInput,
    PaymentInput Function()? paymentInput,
    DiscountReasonInput Function()? discountReasonInput,
    FormzSubmissionStatus Function()? submissionStatus,
    String? Function()? errorMessage,
  }) {
    return CartState._(
      cartItems: cartItems?.call() ?? this.cartItems,
      payments: payments?.call() ?? this.payments,
      selectedPaymentMethod:
          selectedPaymentMethod?.call() ?? this.selectedPaymentMethod,
      quantityInput: quantityInput?.call() ?? this.quantityInput,
      discountInput: discountInput?.call() ?? this.discountInput,
      shippingInput: shippingInput?.call() ?? this.shippingInput,
      discountReasonInput:
          discountReasonInput?.call() ?? this.discountReasonInput,
      paymentInput: paymentInput?.call() ?? this.paymentInput,
      submissionStatus: submissionStatus?.call() ?? this.submissionStatus,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  bool get isQuantityValid => Formz.validate([quantityInput]);

  bool get isDiscountValid => Formz.validate([discountInput]);

  bool get isShippingValid => Formz.validate([shippingInput]);

  bool get isDiscountReasonValid => Formz.validate([discountReasonInput]);

  String? get quantityError {
    if (quantityInput.isPure) return null;
    final error = {
      QuantityInputError.empty: 'A quantidade é obrigatória.',
      QuantityInputError.invalid: 'A quantidade é inválida.',
      QuantityInputError.insufficient: 'Estoque insuficiente.',
    };
    return error[quantityInput.error];
  }

  String? get discountError {
    if (discountInput.isPure) return null;
    final error = {
      DiscountInputError.invalid: 'Desconto inválido.',
      DiscountInputError.negative: 'Desconto não pode ser negativo.',
      DiscountInputError.zero: 'Desconto não pode ser zero.',
      DiscountInputError.exceedsTotal: 'Desconto excede o total.',
    };
    return error[discountInput.error];
  }

  String? get shippingError {
    if (shippingInput.isPure) return null;
    final error = {
      ShippingInputError.invalid: 'Frete inválido.',
      ShippingInputError.negative: 'Frete não pode ser negativo.',
      ShippingInputError.zero: 'Frete não pode ser zero.',
    };
    return error[shippingInput.error];
  }

  String? get discountReasonError {
    if (discountReasonInput.isPure) return null;
    final error = {
      DiscountReasonInputError.empty: 'O motivo do desconto é obrigatório.',
      DiscountReasonInputError.tooShort: 'Motivo do desconto é muito curto.',
    };
    return error[discountReasonInput.error];
  }

  String? get paymentError {
    if (paymentInput.isPure) return null;
    final error = {
      PaymentInputError.empty: 'O valor do pagamento é obrigatório.',
      PaymentInputError.invalid: 'Valor do pagamento é inválido.',
      PaymentInputError.negative: 'Valor do pagamento não pode ser negativo.',
      PaymentInputError.zero: 'Valor do pagamento não pode ser zero.',
      PaymentInputError.exceedsTotal: 'Valor do pagamento excede o total.',
    };
    return error[paymentInput.error];
  }

  Decimal get subtotal => cartItems
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.subtotal.toString()),
      )
      .round(scale: 2);

  Decimal get total {
    Decimal safeParse(String value) {
      if (value.trim().isEmpty) return Decimal.zero;
      try {
        return Decimal.parse(value.replaceAll(',', '.'));
      } catch (_) {
        return Decimal.zero;
      }
    }

    final discount = safeParse(discountInput.value);
    final shipping = safeParse(shippingInput.value);

    if (isDiscountValid && isShippingValid) {
      return (subtotal - discount + shipping).round(scale: 2);
    } else {
      return (subtotal).round(scale: 2);
    }
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    cartItems,
    payments,
    selectedPaymentMethod,
    quantityInput,
    discountInput,
    shippingInput,
    discountReasonInput,
    paymentInput,
    submissionStatus,
    errorMessage,
  ];
}
