import 'package:formz/formz.dart';

enum QuantityInputError { empty, invalid, insufficient }

final class QuantityInput extends FormzInput<String, QuantityInputError> {
  const QuantityInput.pure() : super.pure('');
  const QuantityInput.dirty([super.value = '']) : super.dirty();

  static double _availableStock = 0;

  static void setAvailableStock(double stock) {
    _availableStock = stock;
  }

  static final _quantityRegExp = RegExp(r'^(?!0\d)\d+(?:[.,]\d{1,3})?$');

  @override
  QuantityInputError? validator(String value) {
    if (value.isEmpty) {
      return QuantityInputError.empty;
    }
    final quantity = double.tryParse(value.replaceAll(',', '.'));
    if (quantity == null || quantity <= 0 || !_quantityRegExp.hasMatch(value)) {
      return QuantityInputError.invalid;
    }
    if (quantity > _availableStock) {
      return QuantityInputError.insufficient;
    }
    return null;
  }
}
