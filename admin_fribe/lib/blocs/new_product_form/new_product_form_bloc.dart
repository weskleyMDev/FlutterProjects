import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_measure_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_name_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_price_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_quantity_validator.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'new_product_form_event.dart';
part 'new_product_form_state.dart';

final class NewProductFormBloc
    extends Bloc<NewProductFormEvent, NewProductFormState> {
  final IProductRepository _productRepository;
  NewProductFormBloc({
    required IProductRepository productRepository,
    required ProductModel? initialProduct,
  }) : _productRepository = productRepository,
       super(
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
    emit(state.copyWith(productName: () => productName));
  }

  void _onProductCategoryChanged(
    ProductCategoryChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productCategory = ProductCategoryInput.dirty(event.category);
    emit(state.copyWith(productCategory: () => productCategory));
  }

  void _onProductQuantityChanged(
    ProductQuantityChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productQuantity = ProductQuantityInput.dirty(event.quantity);
    emit(state.copyWith(productQuantity: () => productQuantity));
  }

  void _onProductPriceChanged(
    ProductPriceChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productPrice = ProductPriceInput.dirty(event.price);
    emit(state.copyWith(productPrice: () => productPrice));
  }

  void _onProductMeasureChanged(
    ProductMeasureChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productMeasure = ProductMeasureInput.dirty(event.measure);
    emit(state.copyWith(productMeasure: () => productMeasure));
  }

  Future<void> _onFormSubmitted(
    FormSubmitted event,
    Emitter<NewProductFormState> emit,
  ) async {
    if (!state.isValid) return;
    emit(
      state.copyWith(
        formStatus: () => FormzSubmissionStatus.inProgress,
        errorMessage: null,
      ),
    );
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
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }

  void _onResetProductForm(
    ResetProductForm event,
    Emitter<NewProductFormState> emit,
  ) {
    if (state.initialProduct != null) {
      emit(NewProductFormState.fromProduct(product: state.initialProduct!));
    } else {
      emit(const NewProductFormState.initial());
    }
  }
}
