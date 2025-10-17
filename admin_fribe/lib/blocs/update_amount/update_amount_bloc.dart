import 'package:admin_fribe/blocs/update_amount/validator/amount_input.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';

part 'update_amount_event.dart';
part 'update_amount_state.dart';

final class UpdateAmountBloc
    extends Bloc<UpdateAmountEvent, UpdateAmountState> {
  final IProductRepository _productRepository;
  UpdateAmountBloc(this._productRepository)
    : super(UpdateAmountState.initial()) {
    on<AmountInputChanged>(_onAmountInputChanged);
    on<UpdateAmountSubmitted>(_onUpdateAmountSubmitted);
  }

  void _onAmountInputChanged(
    AmountInputChanged event,
    Emitter<UpdateAmountState> emit,
  ) {
    final amountInput = AmountInput.dirty(event.amount);
    emit(state.copyWith(amountInput: amountInput));
  }

  Future<void> _onUpdateAmountSubmitted(
    UpdateAmountSubmitted event,
    Emitter<UpdateAmountState> emit,
  ) async {
    if (!state.isValid) return;
    emit(
      state.copyWith(
        submissionStatus: FormzSubmissionStatus.inProgress,
        errorMessage: () => null,
      ),
    );
    try {
      await _productRepository.updateProductAmount(
        productId: event.productId,
        newAmount: state.amountInput.value,
      );
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.success,
          errorMessage: () => null,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          submissionStatus: FormzSubmissionStatus.failure,
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }
}
