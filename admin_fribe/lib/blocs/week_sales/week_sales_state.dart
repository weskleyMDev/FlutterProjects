part of 'week_sales_bloc.dart';

enum WeekSalesStatus { initial, inProgress, success, failure }

final class WeekSalesState extends Equatable {
  final List<WeekSales> weekSales;
  final List<WeekProductSales> productsSoldByWeek;
  final WeekSalesStatus status;
  final String locale;
  final String? errorMessage;
  final int selectedYear;
  final int selectedMonth;

  final List<DateTime> allMonths;
  final List<int> allYears;

  const WeekSalesState._({
    required this.weekSales,
    required this.productsSoldByWeek,
    required this.status,
    required this.locale,
    required this.errorMessage,
    required this.selectedYear,
    required this.selectedMonth,
    required this.allMonths,
    required this.allYears,
  });

  factory WeekSalesState.initial() => WeekSalesState._(
    weekSales: [],
    productsSoldByWeek: [],
    status: WeekSalesStatus.initial,
    locale: '',
    selectedMonth: DateTime.now().month,
    selectedYear: DateTime.now().year,
    errorMessage: null,
    allMonths: List.generate(12, (i) => DateTime(0, i + 1)),
    allYears: List.generate(5, (i) => DateTime.now().year - i),
  );

  WeekSalesState copyWith({
    List<WeekSales>? weekSales,
    List<WeekProductSales>? productsSoldByWeek,
    WeekSalesStatus? status,
    String? locale,
    int? selectedMonth,
    int? selectedYear,
    String? errorMessage,
    List<DateTime>? allMonths,
    List<int>? allYears,
    bool clearErrorMessage = false,
  }) => WeekSalesState._(
    weekSales: weekSales ?? this.weekSales,
    productsSoldByWeek: productsSoldByWeek ?? this.productsSoldByWeek,
    status: status ?? this.status,
    locale: locale ?? this.locale,
    selectedMonth: selectedMonth ?? this.selectedMonth,
    selectedYear: selectedYear ?? this.selectedYear,
    errorMessage: clearErrorMessage
        ? null
        : (errorMessage ?? this.errorMessage),
    allMonths: allMonths ?? this.allMonths,
    allYears: allYears ?? this.allYears,
  );

  Decimal _safeParseDecimal(dynamic value) {
    final str = value?.toString().trim();
    if (str == null || str.isEmpty) return Decimal.zero;

    try {
      return Decimal.parse(str);
    } catch (_) {
      return Decimal.zero;
    }
  }

  Decimal _calculateTotalByPaymentType(String paymentType) {
    return weekSales
        .fold<Decimal>(
          Decimal.zero,
          (previousValue, week) =>
              previousValue +
              week.salesReceipts.fold<Decimal>(Decimal.zero, (total, receipt) {
                final payments = receipt.payments;
                final filteredPayments = payments.where(
                  (p) => p.type == paymentType,
                );
                final sum = filteredPayments.fold<Decimal>(Decimal.zero, (
                  subtotal,
                  payment,
                ) {
                  final value = _safeParseDecimal(payment.value);
                  return subtotal + value;
                });
                return total + sum;
              }),
        )
        .round(scale: 2);
  }

  Decimal _sumFromReceipts(Decimal Function(SalesReceipt element) getValue) {
    return weekSales
        .fold<Decimal>(
          Decimal.zero,
          (previousValue, week) =>
              previousValue +
              week.salesReceipts.fold<Decimal>(
                Decimal.zero,
                (receiptSum, element) => receiptSum + getValue(element),
              ),
        )
        .round(scale: 2);
  }

  Decimal get netMonthlyTotal =>
      _sumFromReceipts((element) => _safeParseDecimal(element.total));

  Decimal get totalMonthDiscounts =>
      _sumFromReceipts((element) => _safeParseDecimal(element.discount));

  Decimal get totalMonthShipping =>
      _sumFromReceipts((element) => _safeParseDecimal(element.shipping));

  Decimal get totalMonthTariffs =>
      _sumFromReceipts((element) => _safeParseDecimal(element.tariffs));

  Decimal get totalMonthCash => _calculateTotalByPaymentType('dinheiro');

  Decimal get totalMonthCredit => _calculateTotalByPaymentType('credito');

  Decimal get totalMonthDebit => _calculateTotalByPaymentType('debito');

  Decimal get totalMonthPix => _calculateTotalByPaymentType('pix');

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [
    weekSales,
    productsSoldByWeek,
    status,
    locale,
    selectedMonth,
    selectedYear,
    errorMessage,
    allMonths,
    allYears,
  ];
}
