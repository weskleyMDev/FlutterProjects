import 'package:admin_fribe/blocs/new_product_form/validator/product_name_validator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'new_product_form_event.dart';
part 'new_product_form_state.dart';

final class NewProductFormBloc
    extends Bloc<NewProductFormEvent, NewProductFormState> {
  NewProductFormBloc() : super(const NewProductFormState.initial()) {
    on<ProductNameChanged>(_onProductNameChanged);
    on<ResetProductForm>(_onResetProductForm);
  }

  void _onProductNameChanged(
    ProductNameChanged event,
    Emitter<NewProductFormState> emit,
  ) {
    final productName = ProductNameInput.dirty(event.value);
    emit(state.copyWith(productName: () => productName));
  }

  void _onResetProductForm(
    ResetProductForm event,
    Emitter<NewProductFormState> emit,
  ) {
    emit(const NewProductFormState.initial());
  }
}
