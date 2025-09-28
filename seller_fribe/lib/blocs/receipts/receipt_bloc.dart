import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/models/receipt_model.dart';
import 'package:seller_fribe/repositories/receipts/receipt_repository.dart';

part 'receipt_event.dart';
part 'receipt_state.dart';

final class ReceiptBloc extends Bloc<ReceiptEvent, ReceiptState> {
  final IReceiptRepository _receiptRepository;
  ReceiptBloc(this._receiptRepository) : super(const ReceiptState.initial()) {
    on<CreateReceipt>(_onCreateReceipt);
    on<ReceiptsSubscribedRequest>(_onReceiptsSubscribedRequest);
    on<CreatePendingReceipt>(_onCreatePendingReceipt);
  }

  Future<void> _onReceiptsSubscribedRequest(
    ReceiptsSubscribedRequest event,
    Emitter<ReceiptState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ReceiptStatus.loading,
        errorMessage: () => null,
      ),
    );
    try {
      await emit.forEach<List<ReceiptModel>>(
        _receiptRepository.getReceipts(),
        onData: (receipts) => state.copyWith(
          status: () => ReceiptStatus.success,
          receipts: () => receipts,
        ),
        onError: (error, stackTrace) => state.copyWith(
          status: () => ReceiptStatus.failure,
          errorMessage: () =>
              error is FirebaseException ? error.message : error.toString(),
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: () => ReceiptStatus.failure,
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreatePendingReceipt(
    CreatePendingReceipt event,
    Emitter<ReceiptState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ReceiptStatus.loading,
        errorMessage: () => null,
      ),
    );
    try {
      await _receiptRepository.savePendingReceipt(event.receipt, event.client);
      emit(state.copyWith(status: () => ReceiptStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: () => ReceiptStatus.failure,
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }

  Future<void> _onCreateReceipt(
    CreateReceipt event,
    Emitter<ReceiptState> emit,
  ) async {
    emit(
      state.copyWith(
        status: () => ReceiptStatus.loading,
        errorMessage: () => null,
      ),
    );
    try {
      await _receiptRepository.saveReceipt(event.receipt);
      emit(state.copyWith(status: () => ReceiptStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: () => ReceiptStatus.failure,
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }
}
