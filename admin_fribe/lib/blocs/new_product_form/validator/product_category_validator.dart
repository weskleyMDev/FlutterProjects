import 'package:formz/formz.dart';

enum ProductCategoryInputError { empty, invalid }

enum ProductCategory { bovino, ovino, suino, aves, outros }

final class ProductCategoryInput
    extends FormzInput<String, ProductCategoryInputError> {
  const ProductCategoryInput.pure() : super.pure('');
  const ProductCategoryInput.dirty([super.value = '']) : super.dirty();

  @override
  ProductCategoryInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductCategoryInputError.empty;
    }
    if (!ProductCategory.values.any((e) => e.name.toUpperCase() == value)) {
      return ProductCategoryInputError.invalid;
    }
    return null;
  }
}
