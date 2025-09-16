import 'package:formz/formz.dart';

enum ProductMeasureInputError { empty, invalid }

enum ProductMeasure { kg, un, pc }

final class ProductMeasureInput
    extends FormzInput<String, ProductMeasureInputError> {
  const ProductMeasureInput.pure() : super.pure('');
  const ProductMeasureInput.dirty([super.value = '']) : super.dirty();

  @override
  ProductMeasureInputError? validator(String value) {
    if (value.isEmpty) {
      return ProductMeasureInputError.empty;
    }
    if (!ProductMeasure.values.any((e) => e.name.toUpperCase() == value)) {
      return ProductMeasureInputError.invalid;
    }
    return null;
  }
}
