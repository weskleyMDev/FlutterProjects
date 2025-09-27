part of 'cart_bloc.dart';

final class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final QuantityInput quantityInput;
  final DiscountInput discountInput;
  final ShippingInput shippingInput;
  final DiscountReasonInput discountReasonInput;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const CartState._({
    this.cartItems = const [],
    this.quantityInput = const QuantityInput.pure(),
    this.discountInput = const DiscountInput.pure(),
    this.shippingInput = const ShippingInput.pure(),
    this.discountReasonInput = const DiscountReasonInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  const CartState.initial() : this._();

  CartState copyWith({
    List<CartItemModel> Function()? cartItems,
    QuantityInput Function()? quantityInput,
    DiscountInput Function()? discountInput,
    ShippingInput Function()? shippingInput,
    DiscountReasonInput Function()? discountReasonInput,
    FormzSubmissionStatus Function()? submissionStatus,
    String? Function()? errorMessage,
  }) {
    return CartState._(
      cartItems: cartItems?.call() ?? this.cartItems,
      quantityInput: quantityInput?.call() ?? this.quantityInput,
      discountInput: discountInput?.call() ?? this.discountInput,
      shippingInput: shippingInput?.call() ?? this.shippingInput,
      discountReasonInput:
          discountReasonInput?.call() ?? this.discountReasonInput,
      submissionStatus: submissionStatus?.call() ?? this.submissionStatus,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  bool get isQuantityValid => Formz.validate([quantityInput]);

  bool get isDiscountValid => Formz.validate([discountInput]);

  bool get isShippingValid => Formz.validate([shippingInput]);

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
    quantityInput,
    discountInput,
    shippingInput,
    discountReasonInput,
    submissionStatus,
    errorMessage,
  ];
}
