part of 'product_edit_bloc.dart';

final class ProductEditState extends Equatable {
  final ProductInput productName;
  final PriceInput productPrice;
  final FormzSubmissionStatus status;
  final ProductModel? initialProduct;
  final bool isValid;

  const ProductEditState._({
    this.productName = const ProductInput.pure(),
    this.productPrice = const PriceInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.initialProduct,
    this.isValid = false,
  });

  const ProductEditState.initial() : this._();

  factory ProductEditState.editing(ProductModel? product, String locale) =>
      ProductEditState._(
        productName: ProductInput.dirty(product?.title[locale] ?? ''),
        productPrice: PriceInput.dirty(product?.price.toString() ?? ''),
        status: FormzSubmissionStatus.initial,
        initialProduct: product,
        isValid: Formz.validate([
          ProductInput.dirty(product?.title[locale] ?? ''),
          //PriceInput.dirty(product?.price.toString() ?? ''),
        ]),
      );

  bool get isNewProduct => initialProduct == null;

  String? get productNameError {
    if (productName.isPure) return null;
    final errorText = {
      ProductInputError.empty: 'Product name cannot be empty',
      ProductInputError.invalid: 'Product name contains invalid characters',
      ProductInputError.tooShort: 'Product name is too short',
    };
    return errorText[productName.error];
  }

  String? get productPriceError {
    if (productPrice.isPure) return null;
    final errorText = {
      PriceInputError.empty: 'Price cannot be empty',
      PriceInputError.invalid: 'Price is invalid',
      PriceInputError.negative: 'Price cannot be negative',
    };
    return errorText[productPrice.error];
  }

  ProductEditState copyWith({
    ProductInput Function()? productName,
    PriceInput Function()? productPrice,
    FormzSubmissionStatus Function()? status,
    ProductModel? Function()? initialProduct,
    bool Function()? isValid,
  }) {
    return ProductEditState._(
      productName: productName?.call() ?? this.productName,
      productPrice: productPrice?.call() ?? this.productPrice,
      status: status?.call() ?? this.status,
      initialProduct: initialProduct?.call() ?? this.initialProduct,
      isValid: isValid?.call() ?? this.isValid,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    productName,
    productPrice,
    status,
    initialProduct,
    isValid,
  ];
}
