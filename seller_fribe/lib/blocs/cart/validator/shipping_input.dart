import 'package:formz/formz.dart';

enum ShippingInputError { invalid, negative, zero }

final class ShippingInput extends FormzInput<String, ShippingInputError> {
  const ShippingInput.pure() : super.pure('');
  const ShippingInput.dirty([super.value = '']) : super.dirty();

  static final _shippingRegex = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,2})?$');

  @override
  ShippingInputError? validator(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return null;
    }
    if (!_shippingRegex.hasMatch(value)) {
      return ShippingInputError.invalid;
    }
    final number = num.parse(value.replaceAll(',', '.'));
    if (number < 0) {
      return ShippingInputError.negative;
    }
    if (number == 0) {
      return ShippingInputError.zero;
    }
    return null;
  }
}
