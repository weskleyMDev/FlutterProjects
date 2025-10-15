part of 'cart_bloc.dart';

enum PaymentsMethod { dinheiro, credito, debito, pix, vale }

final class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final List<PaymentModel> payments;
  final PaymentsMethod selectedPaymentMethod;
  final QuantityInput quantityInput;
  final DiscountInput discountInput;
  final ShippingInput shippingInput;
  final TariffsInput tariffsInput;
  final PaymentInput paymentInput;
  final PendingSaleInput pendingSaleInput;
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
    this.tariffsInput = const TariffsInput.pure(),
    this.paymentInput = const PaymentInput.pure(),
    this.pendingSaleInput = const PendingSaleInput.pure(),
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
    TariffsInput Function()? tariffsInput,
    PaymentInput Function()? paymentInput,
    PendingSaleInput Function()? pendingSaleInput,
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
      tariffsInput: tariffsInput?.call() ?? this.tariffsInput,
      paymentInput: paymentInput?.call() ?? this.paymentInput,
      pendingSaleInput: pendingSaleInput?.call() ?? this.pendingSaleInput,
      submissionStatus: submissionStatus?.call() ?? this.submissionStatus,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  bool get isQuantityValid => Formz.validate([quantityInput]);

  bool get isDiscountValid => Formz.validate([discountInput]);

  bool get isShippingValid => Formz.validate([shippingInput]);

  bool get isDiscountReasonValid => Formz.validate([discountReasonInput]);

  bool get isPaymentValid => Formz.validate([paymentInput]);

  bool get isTariffsValid => Formz.validate([tariffsInput]);

  bool get isPendingSaleValid => Formz.validate([pendingSaleInput]);

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

  String? get tariffsError {
    if (tariffsInput.isPure) return null;
    final error = {
      TariffsInputError.invalid: 'Tarifa inválida.',
      TariffsInputError.negative: 'Tarifa não pode ser negativa.',
      TariffsInputError.zero: 'Tarifa não pode ser zero.',
    };
    return error[tariffsInput.error];
  }

  String? get pendingSaleError {
    if (pendingSaleInput.isPure) return null;
    final error = {
      PendingSaleInputError.empty: 'O identificador é obrigatório.',
      PendingSaleInputError.invalid:
          'O identificador só pode conter letras, números e underscores.',
    };
    return error[pendingSaleInput.error];
  }

  Decimal get subtotal => cartItems
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.subtotal.toString().trim()),
      )
      .round(scale: 2);

  Decimal get total {
    Decimal safeParse(String value) {
      if (value.trim().isEmpty) return Decimal.zero;
      try {
        return Decimal.parse(value.trim().replaceAll(',', '.'));
      } catch (_) {
        return Decimal.zero;
      }
    }

    final discount = safeParse(discountInput.value);
    final shipping = safeParse(shippingInput.value);
    final tariffs = safeParse(tariffsInput.value);

    if (isDiscountValid && isShippingValid && isTariffsValid) {
      return ((subtotal + shipping + tariffs) - discount).round(scale: 2);
    } else {
      return (subtotal).round(scale: 2);
    }
  }

  Decimal get paidAmount => payments
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.value.trim().replaceAll(',', '.')),
      )
      .round(scale: 2);

  Decimal get remainingAmount => (total - paidAmount).round(scale: 2);

  bool get canFinalize {
    final hasDiscount = discountInput.value.trim().isNotEmpty;

    final isDiscountValidAndReasoned =
        !hasDiscount || (hasDiscount && isDiscountReasonValid);

    return cartItems.isNotEmpty &&
        remainingAmount <= Decimal.zero &&
        isDiscountValidAndReasoned;
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
    tariffsInput,
    paymentInput,
    pendingSaleInput,
    submissionStatus,
    errorMessage,
  ];
}
