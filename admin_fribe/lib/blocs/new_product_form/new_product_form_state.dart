part of 'new_product_form_bloc.dart';

final class NewProductFormState extends Equatable {
  const NewProductFormState._({
    this.initialProduct,
    this.productName = const ProductNameInput.pure(),
    this.productCategory = const ProductCategoryInput.pure(),
    this.productQuantity = const ProductQuantityInput.pure(),
    this.productPrice = const ProductPriceInput.pure(),
    this.productMeasure = const ProductMeasureInput.pure(),
    this.formStatus = FormzSubmissionStatus.initial,
    this.isFormValid = false,
    this.errorMessage,
  });

  const NewProductFormState.initial() : this._();

  factory NewProductFormState.fromProduct({required ProductModel product}) =>
      NewProductFormState._(
        initialProduct: product,
        productName: ProductNameInput.dirty(product.name),
        productCategory: ProductCategoryInput.dirty(product.category),
        productQuantity: ProductQuantityInput.dirty(product.amount),
        productPrice: ProductPriceInput.dirty(product.price),
        productMeasure: ProductMeasureInput.dirty(product.measure),
        formStatus: FormzSubmissionStatus.initial,
        isFormValid: true,
        errorMessage: null,
      );

  final ProductModel? initialProduct;
  final ProductNameInput productName;
  final ProductCategoryInput productCategory;
  final ProductQuantityInput productQuantity;
  final ProductPriceInput productPrice;
  final ProductMeasureInput productMeasure;
  final FormzSubmissionStatus formStatus;
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

  String? get productQuantityErrorText {
    if (productQuantity.isPure) return null;
    final errorMessage = {
      ProductQuantityInputError.empty: 'Product quantity cannot be empty',
      ProductQuantityInputError.negative: 'Product quantity cannot be negative',
      ProductQuantityInputError.zero: 'Product quantity cannot be zero',
      ProductQuantityInputError.invalid: 'Invalid product quantity',
    };
    return errorMessage[productQuantity.error];
  }

  String? get productPriceErrorText {
    if (productPrice.isPure) return null;
    final errorMessage = {
      ProductPriceInputError.empty: 'Product price cannot be empty',
      ProductPriceInputError.negative: 'Product price cannot be negative',
      ProductPriceInputError.zero: 'Product price cannot be zero',
      ProductPriceInputError.invalid: 'Invalid product price',
    };
    return errorMessage[productPrice.error];
  }

  String? get productMeasureErrorText {
    if (productMeasure.isPure) return null;
    final errorMessage = {
      ProductMeasureInputError.empty: 'Product measure cannot be empty',
      ProductMeasureInputError.invalid: 'Invalid product measure',
    };
    return errorMessage[productMeasure.error];
  }

  NewProductFormState copyWith({
    ProductModel? Function()? initialProduct,
    ProductNameInput Function()? productName,
    ProductCategoryInput Function()? productCategory,
    ProductQuantityInput Function()? productQuantity,
    ProductPriceInput Function()? productPrice,
    ProductMeasureInput Function()? productMeasure,
    FormzSubmissionStatus Function()? formStatus,
    bool Function()? isFormValid,
    String? Function()? errorMessage,
  }) {
    return NewProductFormState._(
      initialProduct: initialProduct?.call() ?? this.initialProduct,
      productName: productName?.call() ?? this.productName,
      productCategory: productCategory?.call() ?? this.productCategory,
      productQuantity: productQuantity?.call() ?? this.productQuantity,
      productPrice: productPrice?.call() ?? this.productPrice,
      productMeasure: productMeasure?.call() ?? this.productMeasure,
      formStatus: formStatus?.call() ?? this.formStatus,
      isFormValid: isFormValid?.call() ?? this.isFormValid,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    initialProduct,
    productName,
    productCategory,
    productQuantity,
    productPrice,
    productMeasure,
    formStatus,
    isFormValid,
    errorMessage,
  ];
}
