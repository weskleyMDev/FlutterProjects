import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

final class ConnectivityBloc
    extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late final StreamSubscription<List<ConnectivityResult>>
  _connectivitySubscription;
  ConnectivityBloc(this._connectivity) : super(ConnectivityState.initial()) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen((
      results,
    ) {
      final isConnected =
          results.isNotEmpty && !results.contains(ConnectivityResult.none);
      add(ConnectivityChanged(isConnected));
    });
    on<CheckConnectivity>(_onCheckConnectivity);
    on<ConnectivityChanged>(_onConnectivityChanged);
  }

  Future<void> _onCheckConnectivity(
    CheckConnectivity event,
    Emitter<ConnectivityState> emit,
  ) async {
    final result = await _connectivity.checkConnectivity();
    final isConnected =
        result.isNotEmpty && !result.contains(ConnectivityResult.none);
    if (isConnected) {
      emit(state.copyWith(status: ConnectivityStatus.connected));
    } else {
      emit(state.copyWith(status: ConnectivityStatus.disconnected));
    }
  }

  void _onConnectivityChanged(
    ConnectivityChanged event,
    Emitter<ConnectivityState> emit,
  ) {
    if (event.isConnected) {
      emit(state.copyWith(status: ConnectivityStatus.connected));
    } else {
      emit(state.copyWith(status: ConnectivityStatus.disconnected));
    }
  }

  @override
  Future<void> close() async {
    await _connectivitySubscription.cancel();
    return super.close();
  }
}
