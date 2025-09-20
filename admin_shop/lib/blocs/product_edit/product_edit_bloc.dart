import 'package:admin_shop/blocs/product_edit/validator/price_input.dart';
import 'package:admin_shop/blocs/product_edit/validator/product_input.dart';
import 'package:admin_shop/models/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:uuid/uuid.dart';

part 'product_edit_event.dart';
part 'product_edit_state.dart';

final class ProductEditBloc extends Bloc<ProductEditEvent, ProductEditState> {
  ProductEditBloc({
    required ProductModel? initialProduct,
    required String locale,
  }) : super(
         initialProduct != null
             ? ProductEditState.editing(initialProduct, locale)
             : const ProductEditState.initial(),
       ) {
    on<ProductNameChanged>(_onProductNameChanged);
    on<ProductPriceChanged>(_onProductPriceChanged);
    on<ProductEditSubmitted>(_onProductEditSubmitted);
    on<ProductEditResetForm>((event, emit) {
      emit(const ProductEditState.initial());
    });
  }

  void _onProductNameChanged(
    ProductNameChanged event,
    Emitter<ProductEditState> emit,
  ) {
    final productName = ProductInput.dirty(event.name);
    emit(
      state.copyWith(
        productName: () => productName,
        isValid: () => Formz.validate([productName, state.productPrice]),
      ),
    );
  }

  void _onProductPriceChanged(
    ProductPriceChanged event,
    Emitter<ProductEditState> emit,
  ) {
    final productPrice = PriceInput.dirty(event.price);
    emit(
      state.copyWith(
        productPrice: () => productPrice,
        isValid: () => Formz.validate([state.productName, productPrice]),
      ),
    );
  }

  Future<void> _onProductEditSubmitted(
    ProductEditSubmitted event,
    Emitter<ProductEditState> emit,
  ) async {
    if (state.isValid) {
      emit(state.copyWith(status: () => FormzSubmissionStatus.inProgress));
      await Future.delayed(const Duration(seconds: 2));
      final product = (state.initialProduct ?? ProductModel.empty()).copyWith(
        id: () => state.initialProduct?.id ?? Uuid().v4(),
        title: () {
          if (state.initialProduct == null) {
            return {event.locale: state.productName.value};
          }
          return {
            ...state.initialProduct!.title,
            event.locale: state.productName.value,
          };
        },
        price: () =>
            state.initialProduct?.price ?? num.parse(state.productPrice.value),
      );
      print(product);
      emit(state.copyWith(status: () => FormzSubmissionStatus.success));
    }
  }
}
