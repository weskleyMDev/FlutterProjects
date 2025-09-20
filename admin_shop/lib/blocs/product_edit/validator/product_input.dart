import 'package:formz/formz.dart';

enum ProductInputError { empty, invalid, tooShort }

final class ProductInput extends FormzInput<String, ProductInputError> {
  const ProductInput.pure() : super.pure('');
  const ProductInput.dirty([super.value = '']) : super.dirty();

  static final _productNameRegex = RegExp(r'^[a-zA-Z0-9/\s]+$');
  static const int _minLength = 3;

  @override
  ProductInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductInputError.empty;
    }
    if (!_productNameRegex.hasMatch(value)) {
      return ProductInputError.invalid;
    }
    if (value.length < _minLength) {
      return ProductInputError.tooShort;
    }
    return null;
  }
}
