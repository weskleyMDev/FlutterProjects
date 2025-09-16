part of 'new_product_form_bloc.dart';

sealed class NewProductFormEvent extends Equatable {
  const NewProductFormEvent();

  @override
  List<Object?> get props => [];
}

final class ProductNameChanged extends NewProductFormEvent {
  const ProductNameChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
}

final class ProductCategoryChanged extends NewProductFormEvent {
  const ProductCategoryChanged(this.value);

  final String value;

  @override
  List<Object?> get props => [value];
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
