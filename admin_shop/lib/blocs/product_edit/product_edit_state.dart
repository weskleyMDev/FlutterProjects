part of 'product_edit_bloc.dart';

final class ProductEditState extends Equatable {
  final ProductInput productName;
  final PriceInput productPrice;
  final ImageUrlInput productImageUrl;
  final SizesInput productSizes;
  final FormzSubmissionStatus status;
  final ProductModel? initialProduct;
  final bool isValid;

  const ProductEditState._({
    this.productName = const ProductInput.pure(),
    this.productPrice = const PriceInput.pure(),
    this.productImageUrl = const ImageUrlInput.pure(),
    this.productSizes = const SizesInput.pure(),
    this.status = FormzSubmissionStatus.initial,
    this.initialProduct,
    this.isValid = false,
  });

  const ProductEditState.initial() : this._();

  factory ProductEditState.editing(ProductModel? product, String locale) =>
      ProductEditState._(
        productName: ProductInput.dirty(product?.title[locale] ?? ''),
        productPrice: PriceInput.dirty(product?.price.toStringAsFixed(2) ?? ''),
        productImageUrl: ImageUrlInput.dirty(product?.images.first ?? ''),
        productSizes: SizesInput.dirty(
          product != null
              ? product.sizes
                    .map(
                      (size) => SizesFilter.values.firstWhere(
                        (e) => e.name == size.toString().toLowerCase(),
                        orElse: () => SizesFilter.m,
                      ),
                    )
                    .toSet()
              : {},
        ),
        status: FormzSubmissionStatus.initial,
        initialProduct: product,
        isValid: Formz.validate([
          ProductInput.dirty(product?.title[locale] ?? ''),
          PriceInput.dirty(product?.price.toString() ?? ''),
          ImageUrlInput.dirty(product?.images.first ?? ''),
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

  String? get productImageUrlError {
    if (productImageUrl.isPure) return null;
    final errorText = {
      ImageUrlInputError.empty: 'Image URL cannot be empty',
      ImageUrlInputError.invalid: 'Image URL is invalid',
    };
    return errorText[productImageUrl.error];
  }

  String? get productSizesError {
    if (productSizes.isPure) return null;
    final errorText = {SizesInputError.empty: 'Select at least one size'};
    return errorText[productSizes.error];
  }

  ProductEditState copyWith({
    ProductInput Function()? productName,
    PriceInput Function()? productPrice,
    ImageUrlInput Function()? productImageUrl,
    SizesInput Function()? productSizes,
    FormzSubmissionStatus Function()? status,
    ProductModel? Function()? initialProduct,
    bool Function()? isValid,
  }) {
    return ProductEditState._(
      productName: productName?.call() ?? this.productName,
      productPrice: productPrice?.call() ?? this.productPrice,
      productImageUrl: productImageUrl?.call() ?? this.productImageUrl,
      productSizes: productSizes?.call() ?? this.productSizes,
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
    productImageUrl,
    productSizes,
    status,
    initialProduct,
    isValid,
  ];
}
