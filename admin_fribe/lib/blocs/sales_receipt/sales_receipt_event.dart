part of 'sales_receipt_bloc.dart';

sealed class SalesReceiptEvent extends Equatable {
  const SalesReceiptEvent();
  @override
  List<Object?> get props => [];
}

final class LoadSalesReceipts extends SalesReceiptEvent {
  const LoadSalesReceipts();

  @override
  List<Object?> get props => [];
}

final class StartDateChanged extends SalesReceiptEvent {
  final DateTime? startDate;

  const StartDateChanged(this.startDate);

  @override
  List<Object?> get props => [startDate];
}

final class EndDateChanged extends SalesReceiptEvent {
  const EndDateChanged(this.endDate);

  final DateTime? endDate;

  @override
  List<Object?> get props => [endDate];
}

final class ClearDates extends SalesReceiptEvent {
  const ClearDates();

  @override
  List<Object?> get props => [];
}
