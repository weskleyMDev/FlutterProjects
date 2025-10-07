import 'package:admin_fribe/models/pending_sale_model.dart';
import 'package:admin_fribe/repositories/pending_sales/pending_sale_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'pending_sale_event.dart';
part 'pending_sale_state.dart';

final class PendingSaleBloc extends Bloc<PendingSaleEvent, PendingSaleState> {
  final IPendingSaleRepository _pendingSaleRepository;
  PendingSaleBloc(this._pendingSaleRepository)
    : super(PendingSaleState.initial()) {
    on<FetchPendingSalesEvent>(_onFetchPendingSales);
    on<UpdatePaymentStatusEvent>(_onUpdatePaymentStatus);
    on<ToggleExpansionEvent>(_onToggleExpansion);
  }

  Future<void> _onFetchPendingSales(
    FetchPendingSalesEvent event,
    Emitter<PendingSaleState> emit,
  ) async {
    emit(PendingSaleState.loading());
    try {
      await emit.forEach<List<PendingSaleModel>>(
        _pendingSaleRepository.getPendingSales(),
        onData: (pendingSales) => PendingSaleState.success(pendingSales),
        onError: (e, _) => e is FirebaseException
            ? PendingSaleState.failure(e.message)
            : PendingSaleState.failure(e.toString()),
      );
    } catch (e) {
      emit(PendingSaleState.failure(e.toString()));
    }
  }

  Future<void> _onUpdatePaymentStatus(
    UpdatePaymentStatusEvent event,
    Emitter<PendingSaleState> emit,
  ) async {
    try {
      await _pendingSaleRepository.updatePaymentStatus(
        pendingSaleId: event.pendingSaleId,
        receiptId: event.receiptId,
        status: event.status,
      );
      emit(
        state.copyWith(
          status: () => PendingSaleStatus.success,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: () => PendingSaleStatus.failure,
          errorMessage: () => e is FirebaseException ? e.message : e.toString(),
        ),
      );
    }
  }

  void _onToggleExpansion(
    ToggleExpansionEvent event,
    Emitter<PendingSaleState> emit,
  ) {
    final expandedTiles = Set<String>.from(state.expandedTiles);
    if (event.isExpanded) {
      expandedTiles.add(event.tileId);
    } else {
      expandedTiles.remove(event.tileId);
    }
    emit(state.copyWith(expandedTiles: () => expandedTiles));
  }
}
