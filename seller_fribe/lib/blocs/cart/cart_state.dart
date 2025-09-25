part of 'cart_bloc.dart';

final class CartState extends Equatable {
  final List<CartItemModel> cartItems;
  final QuantityInput quantityInput;
  final FormzSubmissionStatus submissionStatus;
  final String? errorMessage;

  const CartState._({
    this.cartItems = const [],
    this.quantityInput = const QuantityInput.pure(),
    this.submissionStatus = FormzSubmissionStatus.initial,
    this.errorMessage,
  });

  const CartState.initial() : this._();

  CartState copyWith({
    List<CartItemModel> Function()? cartItems,
    QuantityInput Function()? quantityInput,
    FormzSubmissionStatus Function()? submissionStatus,
    String? Function()? errorMessage,
  }) {
    return CartState._(
      cartItems: cartItems?.call() ?? this.cartItems,
      quantityInput: quantityInput?.call() ?? this.quantityInput,
      submissionStatus: submissionStatus?.call() ?? this.submissionStatus,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  bool get isValid => Formz.validate([quantityInput]);

  String? get quantityError {
    if (quantityInput.isPure) return null;
    final error = {
      QuantityInputError.empty: 'A quantidade é obrigatória.',
      QuantityInputError.invalid: 'A quantidade é inválida.',
      QuantityInputError.insufficient: 'Estoque insuficiente.',
    };
    return error[quantityInput.error];
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    cartItems,
    quantityInput,
    submissionStatus,
    errorMessage,
  ];
}
