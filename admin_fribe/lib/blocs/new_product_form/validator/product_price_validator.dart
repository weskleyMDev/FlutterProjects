import 'package:formz/formz.dart';

enum ProductPriceInputError { empty, invalid, negative, zero }

final class ProductPriceInput
    extends FormzInput<String, ProductPriceInputError> {
  const ProductPriceInput.pure() : super.pure('');
  const ProductPriceInput.dirty([super.value = '']) : super.dirty();

  static final _priceRegex = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,2})?$');

  @override
  ProductPriceInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductPriceInputError.empty;
    }
    final price = num.tryParse(value);
    if (!_priceRegex.hasMatch(value) || price == null) {
      return ProductPriceInputError.invalid;
    }
    if (price < 0) {
      return ProductPriceInputError.negative;
    }
    if (price == 0) {
      return ProductPriceInputError.zero;
    }
    return null;
  }
}
