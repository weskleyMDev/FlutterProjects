part of 'product_bloc.dart';

enum ProductStateStatus { initial, waiting, success, error }

final class ProductState extends Equatable {
  final Map<String, List<ProductModel>> productsByCategory;
  final Map<String, ProductStateStatus> statusByCategory;
  final Map<String, String> errorMessage;

  const ProductState._({
    required this.productsByCategory,
    required this.statusByCategory,
    required this.errorMessage,
  });

  factory ProductState.initial() => const ProductState._(
    productsByCategory: {},
    statusByCategory: {},
    errorMessage: {},
  );

  ProductState copyWith({
    Map<String, List<ProductModel>> Function()? productsByCategory,
    Map<String, ProductStateStatus> Function()? statusByCategory,
    Map<String, String> Function()? errorMessage,
  }) {
    return ProductState._(
      productsByCategory: productsByCategory != null
          ? productsByCategory()
          : this.productsByCategory,
      statusByCategory: statusByCategory != null
          ? statusByCategory()
          : this.statusByCategory,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    productsByCategory,
    statusByCategory,
    errorMessage,
  ];
}
