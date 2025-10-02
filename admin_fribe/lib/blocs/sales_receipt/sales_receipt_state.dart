part of 'sales_receipt_bloc.dart';

enum SalesReceiptStatus { initial, loading, success, failure }

final class SalesReceiptState extends Equatable {
  final List<SalesReceipt> salesReceipts;
  final SalesReceiptStatus salesStatus;
  final String? salesErrorMessage;

  const SalesReceiptState._({
    required this.salesReceipts,
    required this.salesStatus,
    this.salesErrorMessage,
  });

  factory SalesReceiptState.initial() => const SalesReceiptState._(
    salesReceipts: [],
    salesStatus: SalesReceiptStatus.initial,
    salesErrorMessage: null,
  );

  Decimal safeDecimalParse(String? input) {
    if (input == null || input.trim().isEmpty) return Decimal.zero;

    final cleaned = input.replaceAll(RegExp(r'[^\d.-]'), '');

    if (cleaned.isEmpty || cleaned == '.' || cleaned == '-') {
      return Decimal.zero;
    }

    try {
      return Decimal.parse(cleaned);
    } catch (e) {
      print('Erro ao fazer parse de "$input": $e');
      return Decimal.zero;
    }
  }

  Decimal get totalSales => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + safeDecimalParse(element.total),
      )
      .round(scale: 2);

  Decimal get totalDiscount => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + safeDecimalParse(element.discount),
      )
      .round(scale: 2);

  Decimal get totalShipping => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + safeDecimalParse(element.shipping),
      )
      .round(scale: 2);

  Decimal get totalCredit => salesReceipts.fold<Decimal>(Decimal.zero, (
    total,
    receipt,
  ) {
    final payments = receipt.payments;
    final creditPayments = payments.where((p) => p.type == 'Cartão de Crédito');

    final creditSum = creditPayments.fold<Decimal>(Decimal.zero, (
      subtotal,
      payment,
    ) {
      final value = safeDecimalParse((payment.value).replaceAll(',', '.'));
      return subtotal + value;
    });

    return total + creditSum;
  });

  Decimal get totalDebit => salesReceipts.fold<Decimal>(Decimal.zero, (
    total,
    receipt,
  ) {
    final payments = receipt.payments;
    final debitPayments = payments.where((p) => p.type == 'Cartão de Débito');

    final debitSum = debitPayments.fold<Decimal>(Decimal.zero, (
      subtotal,
      payment,
    ) {
      final value = safeDecimalParse((payment.value).replaceAll(',', '.'));
      return subtotal + value;
    });

    return total + debitSum;
  });

  Decimal get totalCash =>
      salesReceipts.fold<Decimal>(Decimal.zero, (total, receipt) {
        final payments = receipt.payments;
        final cashPayments = payments.where((p) => p.type == 'Dinheiro');

        final cashSum = cashPayments.fold<Decimal>(Decimal.zero, (
          subtotal,
          payment,
        ) {
          final value = safeDecimalParse((payment.value).replaceAll(',', '.'));
          return subtotal + value;
        });

        return total + cashSum;
      });

  Decimal get totalPix => salesReceipts.fold<Decimal>(Decimal.zero, (
    total,
    receipt,
  ) {
    final payments = receipt.payments;
    final pixPayments = payments.where((p) => p.type == 'PIX');

    final pixSum = pixPayments.fold<Decimal>(Decimal.zero, (subtotal, payment) {
      final value = safeDecimalParse((payment.value).replaceAll(',', '.'));
      return subtotal + value;
    });

    return total + pixSum;
  });

  Map<String, Decimal> get totalQuantity {
    return salesReceipts
        .expand((e) => e.cart.map((p) => {p.productId: p.quantity}))
        .fold<Map<String, Decimal>>({}, (Map<String, Decimal> prev, product) {
          product.forEach((productId, quantity) {
            prev[productId] =
                (prev[productId] ?? Decimal.zero) +
                safeDecimalParse(quantity.toString());
          });
          return prev;
        });
  }

  SalesReceiptState copyWith({
    List<SalesReceipt> Function()? salesReceipts,
    SalesReceiptStatus Function()? salesStatus,
    String? Function()? salesErrorMessage,
  }) {
    return SalesReceiptState._(
      salesReceipts: salesReceipts?.call() ?? this.salesReceipts,
      salesStatus: salesStatus?.call() ?? this.salesStatus,
      salesErrorMessage: salesErrorMessage?.call() ?? this.salesErrorMessage,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [salesReceipts, salesStatus, salesErrorMessage];
}
