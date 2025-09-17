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

  Decimal get totalSales => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.total),
      )
      .round(scale: 2);

  Decimal get totalDiscount => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.discount),
      )
      .round(scale: 2);

  Decimal get totalShipping => salesReceipts
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.shipping),
      )
      .round(scale: 2);

  Decimal get totalCredit => salesReceipts
      .where(
        (receipt) => receipt.payments.any(
          (payment) => payment.type == 'Cartão de Crédito',
        ),
      )
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.total),
      )
      .round(scale: 2);

  Decimal get totalDebit => salesReceipts
      .where(
        (receipt) => receipt.payments.any(
          (payment) => payment.type == 'Cartão de Débito',
        ),
      )
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.total),
      )
      .round(scale: 2);

  Decimal get totalCash => salesReceipts
      .where(
        (receipt) => receipt.payments.any(
          (payment) => payment.type == 'Dinheiro',
        ),
      )
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.total),
      )
      .round(scale: 2);

  Decimal get totalPix => salesReceipts
      .where(
        (receipt) => receipt.payments.any(
          (payment) => payment.type == 'PIX',
        ),
      )
      .fold<Decimal>(
        Decimal.zero,
        (previousValue, element) =>
            previousValue + Decimal.parse(element.total),
      )
      .round(scale: 2);

  Map<String, Decimal> get totalQuantity {
    return salesReceipts
        .expand((e) => e.cart.map((p) => {p.productId: p.quantity}))
        .fold<Map<String, Decimal>>({}, (Map<String, Decimal> prev, product) {
          product.forEach((productId, quantity) {
            prev[productId] =
                (prev[productId] ?? Decimal.zero) +
                Decimal.parse(quantity.toString());
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
