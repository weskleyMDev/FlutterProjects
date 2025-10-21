import 'dart:async';

import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/repositories/sales_receipt/isales_receipt_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'sales_receipt_event.dart';
part 'sales_receipt_state.dart';

final class SalesReceiptBloc
    extends Bloc<SalesReceiptEvent, SalesReceiptState> {
  final ISalesReceiptRepository _salesReceiptRepository;
  SalesReceiptBloc(this._salesReceiptRepository)
    : super(SalesReceiptState.initial()) {
    on<StartDateChanged>(_onStartDateChanged);
    on<EndDateChanged>(_onEndDateChanged);
    on<ClearDates>(_onClearDates);
    on<LoadSalesReceipts>(
      _onLoadSalesReceipts,
      transformer: (events, mapper) => events
          .debounceTime(const Duration(milliseconds: 300))
          .switchMap(mapper),
    );
  }

  void _onStartDateChanged(
    StartDateChanged event,
    Emitter<SalesReceiptState> emit,
  ) {
    emit(
      state.copyWith(
        startDate: event.startDate,
      ),
    );
  }

  void _onEndDateChanged(
    EndDateChanged event,
    Emitter<SalesReceiptState> emit,
  ) {
    emit(
      state.copyWith(
        endDate: event.endDate,
      ),
    );
  }

  void _onClearDates(
    ClearDates event,
    Emitter<SalesReceiptState> emit,
  ) {
    emit(
      state.copyWith(
        clearStartDate: true,
        clearEndDate: true,
      ),
    );
  }

  Future<void> _onLoadSalesReceipts(
    LoadSalesReceipts event,
    Emitter<SalesReceiptState> emit,
  ) async {
    if (!state.canFetchSalesReceipts) return;
    emit(
      state.copyWith(
        salesStatus: SalesReceiptStatus.loading,
        clearErrorMessage: true,
      ),
    );
    await emit.forEach<List<SalesReceipt>>(
      _salesReceiptRepository.getSalesReceiptsStream(
        startDate: state.startDate!,
        endDate: state.endDate!,
      ),
      onData: (data) => state.copyWith(
        salesReceipts: data,
        salesStatus: SalesReceiptStatus.success,
        clearErrorMessage: true,
        clearStartDate: true,
        clearEndDate: true,
      ),
      onError: (error, _) => state.copyWith(
        salesStatus: SalesReceiptStatus.failure,
        salesErrorMessage: error is FirebaseException
            ? error.message
            : error.toString(),
      ),
    );
  }
}
