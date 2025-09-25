part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

final class ProductState extends Equatable {
  final List<ProductModel> products;
  final ProductStatus status;
  final String? errorMessage;

  const ProductState._({
    this.products = const [],
    this.status = ProductStatus.initial,
    this.errorMessage,
  });

  const ProductState.initial() : this._();

  ProductState withLoading() {
    return ProductState._(
      products: products,
      status: ProductStatus.loading,
      errorMessage: null,
    );
  }

  ProductState withSuccess(List<ProductModel> products) {
    return ProductState._(
      products: products,
      status: ProductStatus.success,
      errorMessage: null,
    );
  }

  ProductState withFailure([String? errorMessage]) {
    return ProductState._(
      products: products,
      status: ProductStatus.failure,
      errorMessage: errorMessage,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [products, status, errorMessage];
}
