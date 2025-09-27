part of 'product_bloc.dart';

sealed class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object?> get props => [];
}

final class ProductSubscribeRequested extends ProductEvent {
  const ProductSubscribeRequested();
}

final class ProductSearchQueryChanged extends ProductEvent {
  const ProductSearchQueryChanged(this.query);

  final String query;

  @override
  List<Object?> get props => [query];
}

