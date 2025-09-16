import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_measure_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_name_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_price_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_quantity_validator.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'new_product_form_event.dart';
part 'new_product_form_state.dart';

final class NewProductFormBloc
    extends Bloc<NewProductFormEvent, NewProductFormState> {
  final IProductRepository _productRepository;
  NewProductFormBloc(this._productRepository, {ProductModel? initialProduct})
    : super(
        initialProduct != null
            ? NewProductFormState.fromProduct(product: initialProduct)
            : const NewProductFormState.initial(),
      ) {
    on<ProductNameChanged>(_onProductNameChanged);
    on<ProductCategoryChanged>(_onProductCategoryChanged);
    on<ProductQuantityChanged>(_onProductQuantityChanged);
    on<ProductPriceChanged>(_onProductPriceChanged);
    on<ProductMeasureChanged>(_onProductMeasureChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<ResetProductForm>(_onResetProductForm);
  }

  void _onProductNameChanged(
    ProductNameChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productName = ProductNameInput.dirty(event.name);
    emit(
      state.copyWith(
        productName: () => productName,
        isFormValid: () => Formz.validate([
          productName,
          state.productCategory,
          state.productQuantity,
          state.productPrice,
          state.productMeasure,
        ]),
      ),
    );
  }

  void _onProductCategoryChanged(
    ProductCategoryChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productCategory = ProductCategoryInput.dirty(event.category);
    emit(
      state.copyWith(
        productCategory: () => productCategory,
        isFormValid: () => Formz.validate([
          state.productName,
          productCategory,
          state.productQuantity,
          state.productPrice,
          state.productMeasure,
        ]),
      ),
    );
  }

  void _onProductQuantityChanged(
    ProductQuantityChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productQuantity = ProductQuantityInput.dirty(event.quantity);
    emit(
      state.copyWith(
        productQuantity: () => productQuantity,
        isFormValid: () => Formz.validate([
          state.productName,
          state.productCategory,
          productQuantity,
          state.productPrice,
          state.productMeasure,
        ]),
      ),
    );
  }

  void _onProductPriceChanged(
    ProductPriceChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productPrice = ProductPriceInput.dirty(event.price);
    emit(
      state.copyWith(
        productPrice: () => productPrice,
        isFormValid: () => Formz.validate([
          state.productName,
          state.productCategory,
          state.productQuantity,
          productPrice,
          state.productMeasure,
        ]),
      ),
    );
  }

  void _onProductMeasureChanged(
    ProductMeasureChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productMeasure = ProductMeasureInput.dirty(event.measure);
    emit(
      state.copyWith(
        productMeasure: () => productMeasure,
        isFormValid: () => Formz.validate([
          state.productName,
          state.productCategory,
          state.productQuantity,
          state.productPrice,
          productMeasure,
        ]),
      ),
    );
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<NewProductFormState> emit,
  ) async {
    if (state.isFormValid) {
      emit(
        state.copyWith(
          formStatus: () => FormzSubmissionStatus.inProgress,
          errorMessage: null,
        ),
      );
    }
    emit(state.copyWith(formStatus: () => FormzSubmissionStatus.inProgress));
    try {
      final newProduct = (state.initialProduct ?? ProductModel.empty())
          .copyWith(
            id: () => state.initialProduct?.id ?? Uuid().v4(),
            amount: () => state.productQuantity.value,
            category: () => state.productCategory.value,
            measure: () => state.productMeasure.value,
            name: () => state.productName.value,
            price: () => state.productPrice.value,
          );

      if (state.initialProduct != null) {
        await _productRepository.updateProduct(newProduct);
      } else {
        await _productRepository.addProduct(newProduct);
      }
      emit(
        state.copyWith(
          formStatus: () => FormzSubmissionStatus.success,
          errorMessage: null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          formStatus: () => FormzSubmissionStatus.failure,
          errorMessage: () => 'Failed to submit the form. Please try again.',
        ),
      );
    }
  }

  void _onResetProductForm(
    ResetProductForm event,
    Emitter<NewProductFormState> emit,
  ) {
    emit(const NewProductFormState.initial());
  }
}
