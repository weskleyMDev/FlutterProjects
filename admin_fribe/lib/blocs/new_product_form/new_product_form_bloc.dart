import 'package:admin_fribe/blocs/new_product_form/validator/product_category_validator.dart';
import 'package:admin_fribe/blocs/new_product_form/validator/product_name_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'new_product_form_event.dart';
part 'new_product_form_state.dart';

final class NewProductFormBloc
    extends Bloc<NewProductFormEvent, NewProductFormState> {
  NewProductFormBloc() : super(const NewProductFormState.initial()) {
    on<ProductNameChanged>(_onProductNameChanged);
    on<ProductCategoryChanged>(_onProductCategoryChanged);
    on<FormSubmitted>(_onFormSubmitted);
    on<ResetProductForm>(_onResetProductForm);
  }

  void _onProductNameChanged(
    ProductNameChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productName = ProductNameInput.dirty(event.value);
    emit(
      state.copyWith(
        productName: () => productName,
        isFormValid: () => Formz.validate([productName, state.productCategory]),
      ),
    );
  }

  void _onProductCategoryChanged(
    ProductCategoryChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productCategory = ProductCategoryInput.dirty(event.value);
    emit(
      state.copyWith(
        productCategory: () => productCategory,
        isFormValid: () => Formz.validate([state.productName, productCategory]),
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
      await Future.delayed(const Duration(seconds: 2));
      emit(state.copyWith(formStatus: () => FormzSubmissionStatus.success));
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
