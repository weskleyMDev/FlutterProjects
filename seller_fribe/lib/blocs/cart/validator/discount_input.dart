import 'package:formz/formz.dart';

enum DiscountInputError { invalid, negative, zero, exceedsTotal }

final class DiscountInput extends FormzInput<String, DiscountInputError> {
  const DiscountInput.pure() : super.pure('');
  const DiscountInput.dirty([super.value = '']) : super.dirty();

  static double _total = 0;

  static void setTotal(double total) {
    _total = total;
  }

  static final _discountRegex = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,2})?$');

  @override
  DiscountInputError? validator(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return null;
    }

    if (!_discountRegex.hasMatch(trimmed)) {
      return DiscountInputError.invalid;
    }

    final number = num.parse(trimmed.replaceAll(',', '.'));

    if (number < 0) {
      return DiscountInputError.negative;
    }
    if (number == 0) {
      return DiscountInputError.zero;
    }
    if (number > _total) {
      return DiscountInputError.exceedsTotal;
    }

    return null;
  }
}
