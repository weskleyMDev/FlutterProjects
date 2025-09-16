import 'package:formz/formz.dart';

enum ProductQuantityInputError { empty, negative, invalid, zero }

final class ProductQuantityInput
    extends FormzInput<String, ProductQuantityInputError> {
  const ProductQuantityInput.pure() : super.pure('');
  const ProductQuantityInput.dirty([super.value = '']) : super.dirty();

  static final _validQuantity = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,3})?$');

  @override
  ProductQuantityInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductQuantityInputError.empty;
    }
    final quantity = num.tryParse(value);
    if (!_validQuantity.hasMatch(value) || quantity == null) {
      return ProductQuantityInputError.invalid;
    }
    if (quantity < 0) {
      return ProductQuantityInputError.negative;
    }
    if (quantity == 0) {
      return ProductQuantityInputError.zero;
    }
    return null;
  }
}
