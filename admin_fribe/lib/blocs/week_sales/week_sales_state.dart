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

  Decimal get totalWeekSales =>
      _sumFromReceipts((element) => _safeParseDecimal(element.total));

  Decimal get totalDiscounts =>
      _sumFromReceipts((element) => _safeParseDecimal(element.discount));

  Decimal get totalShipping =>
      _sumFromReceipts((element) => _safeParseDecimal(element.shipping));

  Decimal get totalTariffs =>
      _sumFromReceipts((element) => _safeParseDecimal(element.tariffs));

  Decimal get totalWeekSalesCash => _calculateTotalByPaymentType('dinheiro');

  Decimal get totalWeekSalesCredit => _calculateTotalByPaymentType('credito');

  Decimal get totalWeekSalesDebit => _calculateTotalByPaymentType('debito');

  Decimal get totalWeekSalesPix => _calculateTotalByPaymentType('pix');

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
