part of 'new_product_form_bloc.dart';

sealed class NewProductFormEvent extends Equatable {
  const NewProductFormEvent();

  @override
  List<Object?> get props => [];
}

final class ProductNameChanged extends NewProductFormEvent {
  const ProductNameChanged(this.name);

  final String name;

  @override
  List<Object?> get props => [name];
}

final class ProductCategoryChanged extends NewProductFormEvent {
  const ProductCategoryChanged(this.category);

  final String category;

  @override
  List<Object?> get props => [category];
}

final class ProductQuantityChanged extends NewProductFormEvent {
  const ProductQuantityChanged(this.quantity);

  final String quantity;

  @override
  List<Object?> get props => [quantity];
}

final class ProductPriceChanged extends NewProductFormEvent {
  const ProductPriceChanged(this.price);

  final String price;

  @override
  List<Object?> get props => [price];
}

final class ProductMeasureChanged extends NewProductFormEvent {
  const ProductMeasureChanged(this.measure);

  final String measure;

  @override
  List<Object?> get props => [measure];
}

final class FormSubmitted extends NewProductFormEvent {
  const FormSubmitted();

  @override
  List<Object?> get props => [];
}

final class ResetProductForm extends NewProductFormEvent {
  const ResetProductForm();

  @override
  List<Object?> get props => [];
}
