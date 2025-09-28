import 'package:formz/formz.dart';

enum TariffsInputError { invalid, negative, zero }

final class TariffsInput extends FormzInput<String, TariffsInputError> {
  const TariffsInput.pure() : super.pure('');
  const TariffsInput.dirty([super.value = '']) : super.dirty();

  static final _tariffsRegex = RegExp(r'^-?(0|[1-9]\d*)([.,]\d{1,2})?$');

  @override
  TariffsInputError? validator(String value) {
    final trimmed = value.trim();

    if (trimmed.isEmpty) {
      return null;
    }
    if (!_tariffsRegex.hasMatch(value)) {
      return TariffsInputError.invalid;
    }
    final number = num.parse(value.replaceAll(',', '.'));
    if (number < 0) {
      return TariffsInputError.negative;
    }
    if (number == 0) {
      return TariffsInputError.zero;
    }
    return null;
  }
}
