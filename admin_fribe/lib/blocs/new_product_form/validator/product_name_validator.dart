import 'package:formz/formz.dart';

enum ProductNameInputError { empty, tooShort, invalidCharacters }

final class ProductNameInput extends FormzInput<String, ProductNameInputError> {
  const ProductNameInput.pure() : super.pure('');
  const ProductNameInput.dirty([super.value = '']) : super.dirty();

  static final _nameRegExp = RegExp(r'^[a-zA-Z0-9\s/]+$');

  @override
  ProductNameInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductNameInputError.empty;
    }
    if (value.length < 3) {
      return ProductNameInputError.tooShort;
    }
    if (!_nameRegExp.hasMatch(value)) {
      return ProductNameInputError.invalidCharacters;
    }
    return null;
  }
}
