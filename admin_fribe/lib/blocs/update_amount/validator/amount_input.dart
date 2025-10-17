import 'package:formz/formz.dart';

enum AmountInputError { empty, invalid, negative, zero }

final class AmountInput extends FormzInput<String, AmountInputError> {
  const AmountInput.pure() : super.pure('');
  const AmountInput.dirty([super.value = '']) : super.dirty();

  static final RegExp _validNumberRegExp = RegExp(
    r'^-?(0|[1-9]\d*)([.,]\d{1,3})?$',
  );

  @override
  AmountInputError? validator(String value) {
    if (value.isEmpty) {
      return AmountInputError.empty;
    }
    final parsed = double.tryParse(value);
    if (!_validNumberRegExp.hasMatch(value) || parsed == null) {
      return AmountInputError.invalid;
    }
    if (parsed < 0) {
      return AmountInputError.negative;
    }
    if (parsed == 0) {
      return AmountInputError.zero;
    }
    return null;
  }
}
