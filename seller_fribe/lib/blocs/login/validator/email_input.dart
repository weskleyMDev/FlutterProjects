import 'package:formz/formz.dart';

enum EmailInputError { empty, invalid }

final class EmailInput extends FormzInput<String, EmailInputError> {
  const EmailInput.pure() : super.pure('');
  const EmailInput.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  @override
  EmailInputError? validator(String value) {
    if (value.isEmpty) {
      return EmailInputError.empty;
    }
    if (!_emailRegExp.hasMatch(value)) {
      return EmailInputError.invalid;
    }
    return null;
  }
}
