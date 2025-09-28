import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/blocs/pending_sales/pending_sales_event.dart';
import 'package:seller_fribe/blocs/pending_sales/pending_sales_state.dart';
import 'package:seller_fribe/models/pending_receipt_model.dart';
import 'package:seller_fribe/repositories/pending_sales/pending_sale_repository.dart';

final class PendingSalesBloc
    extends Bloc<PendingSalesEvent, PendingSalesState> {
  final IPendingSaleRepository _pendingSaleRepository;

  PendingSalesBloc(this._pendingSaleRepository)
    : super(PendingSalesState.initial()) {
    on<LoadPendingSales>(_onLoadPendingSales);
  }

  Future<void> _onLoadPendingSales(
    LoadPendingSales event,
    Emitter<PendingSalesState> emit,
  ) async {
    emit(PendingSalesState.loading());
    try {
      final pendingSales = _pendingSaleRepository
          .getPendingReceiptsGroupedById();
      await emit.forEach<List<PendingReceiptModel>>(
        pendingSales,
        onData: (pendingSales) => PendingSalesState.success(pendingSales),
      );
    } catch (e) {
      emit(
        PendingSalesState.failure(
          e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }
}
