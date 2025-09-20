part of 'product_edit_bloc.dart';

sealed class ProductEditEvent extends Equatable {
  const ProductEditEvent();

  @override
  List<Object?> get props => [];
}

final class ProductNameChanged extends ProductEditEvent {
  final String name;

  const ProductNameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

final class ProductPriceChanged extends ProductEditEvent {
  final String price;

  const ProductPriceChanged(this.price);

  @override
  List<Object?> get props => [price];
}

final class ProductEditSubmitted extends ProductEditEvent {
  final String locale;
  const ProductEditSubmitted({required this.locale});

  @override
  List<Object?> get props => [locale];
}

final class ProductEditResetForm extends ProductEditEvent {
  const ProductEditResetForm();

  @override
  List<Object?> get props => [];
}
