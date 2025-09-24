import 'package:formz/formz.dart';

enum PasswordInputError { empty, short }

final class PasswordInput extends FormzInput<String, PasswordInputError> {
  const PasswordInput.pure() : super.pure('');
  const PasswordInput.dirty([super.value = '']) : super.dirty();

  @override
  PasswordInputError? validator(String value) {
    if (value.isEmpty) {
      return PasswordInputError.empty;
    }
    if (value.length < 6) {
      return PasswordInputError.short;
    }
    return null;
  }
}
