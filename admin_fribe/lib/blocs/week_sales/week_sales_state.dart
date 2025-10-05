part of 'week_sales_bloc.dart';

enum WeekSalesStatus { initial, inProgress, success, failure }

final class WeekSalesState extends Equatable {
  final List<WeekSales> weekSales;
  final List<WeekProductSales> productsSoldByWeek;
  final WeekSalesStatus status;
  final String locale;
  final String? selectedMonth;
  final String? errorMessage;

  final List<String> allMonths;
  final List<SalesReceipt> originalReceipts;

  const WeekSalesState._({
    required this.weekSales,
    required this.productsSoldByWeek,
    required this.status,
    required this.locale,
    required this.selectedMonth,
    this.errorMessage,
    required this.allMonths,
    required this.originalReceipts,
  });

  factory WeekSalesState.initial() => const WeekSalesState._(
    weekSales: [],
    productsSoldByWeek: [],
    status: WeekSalesStatus.initial,
    locale: '',
    selectedMonth: '',
    errorMessage: null,
    allMonths: [],
    originalReceipts: [],
  );

  WeekSalesState copyWith({
    List<WeekSales>? weekSales,
    List<WeekProductSales>? productsSoldByWeek,
    WeekSalesStatus? status,
    String? locale,
    String? selectedMonth,
    String? errorMessage,
    List<String>? allMonths,
    List<SalesReceipt>? originalReceipts,
    bool clearErrorMessage = false,
  }) => WeekSalesState._(
    weekSales: weekSales ?? this.weekSales,
    productsSoldByWeek: productsSoldByWeek ?? this.productsSoldByWeek,
    status: status ?? this.status,
    locale: locale ?? this.locale,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    errorMessage: clearErrorMessage ? null : errorMessage ?? this.errorMessage,
    allMonths: allMonths ?? this.allMonths,
    originalReceipts: originalReceipts ?? this.originalReceipts,
  );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    weekSales,
    productsSoldByWeek,
    status,
    locale,
    selectedMonth,
    errorMessage,
    allMonths,
    originalReceipts,
  ];
}
