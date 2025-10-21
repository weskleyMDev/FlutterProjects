part of 'week_sales_bloc.dart';

sealed class WeekSalesEvent extends Equatable {
  const WeekSalesEvent();

  @override
  List<Object> get props => [];
}

final class WeekSalesRequested extends WeekSalesEvent {
  final String locale;
  final DateTime month;

  const WeekSalesRequested({required this.locale, required this.month});

  @override
  List<Object> get props => [locale, month];
}
