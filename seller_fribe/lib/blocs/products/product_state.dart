part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

final class ProductState extends Equatable {
  final List<ProductModel> allProducts;
  final List<ProductModel> filteredProducts;
  final SearchInput searchInput;
  final ProductStatus status;
  final String? errorMessage;

  const ProductState._({
    this.allProducts = const [],
    this.filteredProducts = const [],
    this.searchInput = const SearchInput.pure(),
    this.status = ProductStatus.initial,
    this.errorMessage,
  });

  const ProductState.initial() : this._();

  ProductState withLoading() {
    return ProductState._(
      allProducts: allProducts,
      filteredProducts: filteredProducts,
      searchInput: searchInput,
      status: ProductStatus.loading,
      errorMessage: null,
    );
  }

  ProductState withSuccess(List<ProductModel> products) {
    return ProductState._(
      allProducts: products,
      filteredProducts: products,
      searchInput: searchInput,
      status: ProductStatus.success,
      errorMessage: null,
    );
  }

  ProductState withFailure([String? errorMessage]) {
    return ProductState._(
      allProducts: allProducts,
      filteredProducts: filteredProducts,
      searchInput: searchInput,
      status: ProductStatus.failure,
      errorMessage: errorMessage,
    );
  }

  ProductState withSearch(String query) {
    final newSearch = SearchInput.dirty(query);
    final newFiltered = allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    return ProductState._(
      allProducts: allProducts,
      filteredProducts: newFiltered,
      searchInput: newSearch,
      status: status,
      errorMessage: null,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    allProducts,
    filteredProducts,
    searchInput,
    status,
    errorMessage,
  ];
}
