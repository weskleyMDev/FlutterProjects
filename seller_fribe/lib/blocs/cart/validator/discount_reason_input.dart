import 'package:formz/formz.dart';

enum DiscountReasonInputError { empty, tooShort }

final class DiscountReasonInput
    extends FormzInput<String, DiscountReasonInputError> {
  const DiscountReasonInput.pure() : super.pure('');
  const DiscountReasonInput.dirty([super.value = '']) : super.dirty();

  @override
  DiscountReasonInputError? validator(String value) {
    if (value.isEmpty) {
      return DiscountReasonInputError.empty;
    }
    if (value.length < 3) {
      return DiscountReasonInputError.tooShort;
    }
    return null;
  }
}
