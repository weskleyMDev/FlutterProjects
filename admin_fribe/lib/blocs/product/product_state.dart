part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final List<ProductModel?> products;
  final Map<String, List<CartProduct>> cartProduct;
  final ProductStatus status;
  final String? errorMessage;

  const ProductState._({
    required this.products,
    required this.cartProduct,
    required this.status,
    required this.errorMessage,
  });

  factory ProductState.initial() => const ProductState._(
    products: [],
    cartProduct: {},
    status: ProductStatus.initial,
    errorMessage: null,
  );

  ProductState copyWith({
    List<ProductModel?> Function()? products,
    Map<String, List<CartProduct>> Function()? cartProduct,
    ProductStatus Function()? status,
    String? Function()? errorMessage,
  }) {
    return ProductState._(
      products: products?.call() ?? this.products,
      cartProduct: cartProduct?.call() ?? this.cartProduct,
      status: status?.call() ?? this.status,
      errorMessage: errorMessage?.call() ?? this.errorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [products, cartProduct, status, errorMessage];
}
