part of 'new_product_form_bloc.dart';

final class NewProductFormState extends Equatable {
  const NewProductFormState._({
    this.productName = const ProductNameInput.pure(),
    this.productCategory = const ProductCategoryInput.pure(),
    this.isFormValid = false,
    this.errorMessage,
  });

  const NewProductFormState.initial() : this._();

  final ProductNameInput productName;
  final ProductCategoryInput productCategory;
  final bool isFormValid;
  final String? errorMessage;

  String? get productNameErrorText {
    if (productName.isPure) return null;
    final errorMessage = {
      ProductNameInputError.empty: 'Product name cannot be empty',
      ProductNameInputError.tooShort:
          'Product name must be at least 3 characters',
      ProductNameInputError.invalidCharacters:
          'Product name contains invalid characters',
    };
    return errorMessage[productName.error];
  }

  String? get productCategoryErrorText {
    if (productCategory.isPure) return null;
    final errorMessage = {
      ProductCategoryInputError.empty: 'Product category cannot be empty',
      ProductCategoryInputError.invalid: 'Invalid product category',
    };
    return errorMessage[productCategory.error];
  }

  bool get isFormEmpty => productName.isPure || productCategory.isPure;

  bool get isFormNotValid =>
      productName.isNotValid || productCategory.isNotValid;

  NewProductFormState copyWith({
    ProductNameInput Function()? productName,
    ProductCategoryInput Function()? productCategory,
    bool Function()? isFormValid,
    String? Function()? errorMessage,
  }) {
    return NewProductFormState._(
      productName: productName?.call() ?? this.productName,
      productCategory: productCategory?.call() ?? this.productCategory,
      isFormValid: isFormValid?.call() ?? this.isFormValid,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    productName,
    productCategory,
    isFormValid,
    errorMessage,
  ];
}
