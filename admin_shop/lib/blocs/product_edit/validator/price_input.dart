import 'package:formz/formz.dart';

enum PriceInputError { empty, invalid, negative }

final class PriceInput extends FormzInput<String, PriceInputError> {
  const PriceInput.pure() : super.pure('');
  const PriceInput.dirty([super.value = '']) : super.dirty();

  static final _priceRegExp = RegExp(r'^[+-]?(0|[1-9]\d*)(\.\d{1,2})?$');

  @override
  PriceInputError? validator(String value) {
    if (value.isEmpty) {
      return PriceInputError.empty;
    }
    if (!_priceRegExp.hasMatch(value)) {
      return PriceInputError.invalid;
    }
    if (double.tryParse(value) != null && double.parse(value) < 0) {
      return PriceInputError.negative;
    }
    return null;
  }
}
