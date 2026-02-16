import 'package:admin_fribe/blocs/update_amount/validator/amount_input.dart';
import 'package:admin_fribe/logs/update_amount_log.dart';
import 'package:admin_fribe/repositories/products/product_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:intl/intl.dart';

part 'update_amount_event.dart';
part 'update_amount_state.dart';

final class UpdateAmountBloc
    extends Bloc<UpdateAmountEvent, UpdateAmountState> {
  final IProductRepository _productRepository;
  final IUpdateAmountLog _updateAmountLog;
  UpdateAmountBloc(this._productRepository, this._updateAmountLog)
    : super(UpdateAmountState.initial()) {
    on<AmountInputChanged>(_onAmountInputChanged);
    on<ClearAmountInput>(_onClearAmountInput);
    on<UpdateAmountSubmitted>(_onUpdateAmountSubmitted);
  }

  void _onAmountInputChanged(
    AmountInputChanged event,
    Emitter<UpdateAmountState> emit,
  ) {
    final amountInput = AmountInput.dirty(event.amount);
    emit(state.copyWith(amountInput: amountInput));
  }

  void _onClearAmountInput(
    ClearAmountInput event,
    Emitter<UpdateAmountState> emit,
  ) {
    emit(UpdateAmountState.initial());
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
      final now = DateTime.now();
      final formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(now);

      await _updateAmountLog.writeLog( 
        logEntry: 'Product ID: ${event.productId}, New Amount: ${state.amountInput.value}, Updated At: $formattedDate',
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
