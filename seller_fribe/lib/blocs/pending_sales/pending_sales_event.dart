import 'package:equatable/equatable.dart';

sealed class PendingSalesEvent extends Equatable {
  const PendingSalesEvent();

  @override
  List<Object?> get props => [];
}

final class LoadPendingSales extends PendingSalesEvent {
  const LoadPendingSales();
}