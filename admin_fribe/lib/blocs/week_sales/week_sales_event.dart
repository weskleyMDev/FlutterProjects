part of 'week_sales_bloc.dart';

sealed class WeekSalesEvent extends Equatable {
  const WeekSalesEvent();

  @override
  List<Object> get props => [];
}

final class WeekSalesRequested extends WeekSalesEvent {
  final String locale;
  final String month;
  final List<SalesReceipt> receipts;

  const WeekSalesRequested({
    required this.locale,
    required this.month,
    required this.receipts,
  });

  @override
  List<Object> get props => [locale, month, receipts];
}