part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();
  @override
  List<Object> get props => [];
}

final class ProductsOverviewSubscriptionRequested extends ProductEvent {
  final String category;
  const ProductsOverviewSubscriptionRequested(this.category);
  @override
  List<Object> get props => [category];
}
