import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_name_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_product_form_event.dart';
part 'new_product_form_state.dart';

final class NewProductFormBloc
    extends Bloc<NewProductFormEvent, NewProductFormState> {
  NewProductFormBloc() : super(const NewProductFormState.initial()) {
    on<ProductNameChanged>(_onProductNameChanged);
    on<ProductCategoryChanged>(_onProductCategoryChanged);
    on<ValidateForm>(_onValidateForm);
    on<ResetProductForm>(_onResetProductForm);
  }

  void _onProductNameChanged(
    ProductNameChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productName = ProductNameInput.dirty(event.value);
    emit(state.copyWith(productName: () => productName));
  }

  void _onProductCategoryChanged(
    ProductCategoryChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productCategory = ProductCategoryInput.dirty(event.value);
    emit(state.copyWith(productCategory: () => productCategory));
  }

  void _onValidateForm(ValidateForm event, Emitter<NewProductFormState> emit) {
    if (state.isFormEmpty) {
      emit(
        state.copyWith(
          errorMessage: () => 'Please fill out all fields',
          isFormValid: () => false,
        ),
      );
    } else if (state.isFormNotValid) {
      emit(
        state.copyWith(
          errorMessage: () => 'Please fix the errors in the form.',
          isFormValid: () => false,
        ),
      );
    } else {
      emit(state.copyWith(errorMessage: null, isFormValid: () => true));
    }
  }

  void _onResetProductForm(
    ResetProductForm event,
    Emitter<NewProductFormState> emit,
  ) {
    emit(const NewProductFormState.initial());
  }
}
