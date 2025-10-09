import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';

final class WeekSales extends Equatable {
  final String id;
  final List<SalesReceipt> salesReceipts;

  const WeekSales._({required this.id, required this.salesReceipts});

  factory WeekSales.empty() => const WeekSales._(id: '', salesReceipts: []);

  WeekSales copyWith({String? id, List<SalesReceipt>? salesReceipts}) =>
      WeekSales._(
        id: id ?? this.id,
        salesReceipts: salesReceipts ?? this.salesReceipts,
      );

  WeekSales addReceipt(SalesReceipt receipt) {
    return copyWith(salesReceipts: [...salesReceipts, receipt]);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [id, salesReceipts];
}

extension WeekSalesCalculations on WeekSales {
  Decimal _safeParseDecimal(dynamic value) {
    final str = value?.toString().trim();
    if (str == null || str.isEmpty) return Decimal.zero;

    try {
      return Decimal.parse(str);
    } catch (_) {
      return Decimal.zero;
    }
  }

  Decimal get totalSales => _sumFromReceipts((r) => _safeParseDecimal(r.total));
  Decimal get totalDiscounts =>
      _sumFromReceipts((r) => _safeParseDecimal(r.discount));
  Decimal get totalShipping =>
      _sumFromReceipts((r) => _safeParseDecimal(r.shipping));
  Decimal get totalTariffs =>
      _sumFromReceipts((r) => _safeParseDecimal(r.tariffs));

  Decimal get totalCash => _calculateTotalByPaymentType('dinheiro');
  Decimal get totalCredit => _calculateTotalByPaymentType('credito');
  Decimal get totalDebit => _calculateTotalByPaymentType('debito');
  Decimal get totalPix => _calculateTotalByPaymentType('pix');

  Decimal _sumFromReceipts(Decimal Function(SalesReceipt) getter) {
    return salesReceipts
        .fold<Decimal>(Decimal.zero, (sum, receipt) => sum + getter(receipt))
        .round(scale: 2);
  }

  Decimal _calculateTotalByPaymentType(String type) {
    return salesReceipts
        .fold<Decimal>(Decimal.zero, (sum, receipt) {
          final payments = receipt.payments.where((p) => p.type == type);
          final value = payments.fold<Decimal>(
            Decimal.zero,
            (subtotal, payment) => subtotal + _safeParseDecimal(payment.value),
          );
          return sum + value;
        })
        .round(scale: 2);
  }
}
