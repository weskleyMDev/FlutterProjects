part of 'pending_sale_bloc.dart';

sealed class PendingSaleEvent extends Equatable {
  const PendingSaleEvent();

  @override
  List<Object?> get props => [];
}

final class FetchPendingSalesEvent extends PendingSaleEvent {
  const FetchPendingSalesEvent();

  @override
  List<Object?> get props => [];
}
