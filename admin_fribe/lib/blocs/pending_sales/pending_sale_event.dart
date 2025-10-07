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

final class UpdatePaymentStatusEvent extends PendingSaleEvent {
  final bool status;
  final String pendingSaleId;
  final String receiptId;

  const UpdatePaymentStatusEvent({
    required this.status,
    required this.pendingSaleId,
    required this.receiptId,
  });

  @override
  List<Object?> get props => [status, pendingSaleId, receiptId];
}

final class ToggleExpansionEvent extends PendingSaleEvent {
  final String tileId;
  final bool isExpanded;

  const ToggleExpansionEvent({required this.tileId, required this.isExpanded});

  @override
  List<Object?> get props => [tileId, isExpanded];
}
