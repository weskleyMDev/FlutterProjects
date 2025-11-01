part of 'week_sales_bloc.dart';

sealed class WeekSalesEvent extends Equatable {
  const WeekSalesEvent();

  @override
  List<Object> get props => [];
}

final class WeekSalesRequested extends WeekSalesEvent {
  final String locale;
  final int month;
  final int year;

  const WeekSalesRequested({
    required this.locale,
    required this.month,
    required this.year,
  });

  @override
  List<Object> get props => [locale, month, year];
}
