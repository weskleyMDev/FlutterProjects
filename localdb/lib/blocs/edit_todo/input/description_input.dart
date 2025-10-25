import 'package:formz/formz.dart';

enum DescriptionInputError { empty, invalid, tooShort, tooLong }

final class DescriptionInput extends FormzInput<String, DescriptionInputError> {
  const DescriptionInput.pure() : super.pure('');
  const DescriptionInput.dirty([super.value = '']) : super.dirty();

  static const int _minLength = 10;
  static const int _maxLength = 200;
  static final _validationRegex = RegExp(r'^[A-Za-z0-9_-]+$');

  @override
  DescriptionInputError? validator(String value) {
    if (value.isEmpty) {
      return DescriptionInputError.empty;
    }
    if (!_validationRegex.hasMatch(value)) {
      return DescriptionInputError.invalid;
    }
    if (value.length < _minLength) {
      return DescriptionInputError.tooShort;
    }
    if (value.length > _maxLength) {
      return DescriptionInputError.tooLong;
    }
    return null;
  }
}
