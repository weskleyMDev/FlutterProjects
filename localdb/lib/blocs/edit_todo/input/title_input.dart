import 'package:formz/formz.dart';

enum TitleInputError { empty, invalid, tooShort, tooLong }

final class TitleInput extends FormzInput<String, TitleInputError> {
  const TitleInput.pure() : super.pure('');
  const TitleInput.dirty([super.value = '']) : super.dirty();

  static const int _minLength = 3;
  static const int _maxLength = 50;
  static final _validationRegex = RegExp(r'^[A-Za-z0-9_-]+$');

  @override
  TitleInputError? validator(String value) {
    if (value.isEmpty) {
      return TitleInputError.empty;
    }
    if (!_validationRegex.hasMatch(value)) {
      return TitleInputError.invalid;
    }
    if (value.length < _minLength) {
      return TitleInputError.tooShort;
    }
    if (value.length > _maxLength) {
      return TitleInputError.tooLong;
    }
    return null;
  }
}
