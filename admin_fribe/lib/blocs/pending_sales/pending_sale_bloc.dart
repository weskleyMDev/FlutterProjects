import 'dart:async';

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
  }

  FutureOr<void> _onFetchPendingSales(
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
}
