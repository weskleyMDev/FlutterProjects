part of 'new_product_form_bloc.dart';

final class NewProductFormState extends Equatable {
  const NewProductFormState._({
    this.productName = const ProductNameInput.pure(),
  });

  const NewProductFormState.initial() : this._();

  final ProductNameInput productName;

  String? get productNameErrorText {
    if (productName.isPure) return null;
    final errorMessage = {
      ProductNameInputError.empty: 'Product name cannot be empty',
      ProductNameInputError.tooShort:
          'Product name must be at least 3 characters',
      ProductNameInputError.invalidCharacters:
          'Product name contains invalid characters',
    };
    return errorMessage[productName.error];
  }

  NewProductFormState copyWith({ProductNameInput Function()? productName}) {
    return NewProductFormState._(
      productName: productName?.call() ?? this.productName,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [productName];
}
