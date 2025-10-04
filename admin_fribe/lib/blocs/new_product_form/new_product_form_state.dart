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
        errorMessage: null,
      );

  final ProductModel? initialProduct;
  final ProductNameInput productName;
  final ProductCategoryInput productCategory;
  final ProductQuantityInput productQuantity;
  final ProductPriceInput productPrice;
  final ProductMeasureInput productMeasure;
  final FormzSubmissionStatus formStatus;
  final String? errorMessage;

  bool get isNewProduct => initialProduct == null;

  bool get isValid => Formz.validate([
    productName,
    productCategory,
    productQuantity,
    productPrice,
    productMeasure,
  ]);

  String? _getErrorText<T extends Enum>(
    FormzInput input,
    Map<T, String> messages,
  ) {
    if (input.isPure || input.error == null) return null;
    return messages[input.error as T];
  }

  String? get productNameErrorText =>
      _getErrorText<ProductNameInputError>(productName, {
        ProductNameInputError.empty: 'Product name cannot be empty',
        ProductNameInputError.invalidCharacters:
            'Product name contains invalid characters',
        ProductNameInputError.tooShort:
            'Product name must be at least 3 characters',
      });

  String? get productCategoryErrorText =>
      _getErrorText<ProductCategoryInputError>(productCategory, {
        ProductCategoryInputError.empty: 'Product category cannot be empty',
        ProductCategoryInputError.invalid: 'Invalid product category',
      });

  String? get productQuantityErrorText =>
      _getErrorText<ProductQuantityInputError>(productQuantity, {
        ProductQuantityInputError.empty: 'Product quantity cannot be empty',
        ProductQuantityInputError.negative:
            'Product quantity cannot be negative',
        ProductQuantityInputError.zero: 'Product quantity cannot be zero',
        ProductQuantityInputError.invalid: 'Invalid product quantity',
      });

  String? get productPriceErrorText =>
      _getErrorText<ProductPriceInputError>(productPrice, {
        ProductPriceInputError.empty: 'Product price cannot be empty',
        ProductPriceInputError.negative: 'Product price cannot be negative',
        ProductPriceInputError.zero: 'Product price cannot be zero',
        ProductPriceInputError.invalid: 'Invalid product price',
      });

  String? get productMeasureErrorText =>
      _getErrorText<ProductMeasureInputError>(productMeasure, {
        ProductMeasureInputError.empty: 'Product measure cannot be empty',
        ProductMeasureInputError.invalid: 'Invalid product measure',
      });

  NewProductFormState copyWith({
    ProductModel? Function()? initialProduct,
    ProductNameInput Function()? productName,
    ProductCategoryInput Function()? productCategory,
    ProductQuantityInput Function()? productQuantity,
    ProductPriceInput Function()? productPrice,
    ProductMeasureInput Function()? productMeasure,
    FormzSubmissionStatus Function()? formStatus,
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
    errorMessage,
  ];
}
