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

  Decimal get totalSales => salesReceipts.fold<Decimal>(
    Decimal.zero,
    (previousValue, element) => previousValue + Decimal.parse(element.total),
  );

  Decimal get totalDiscount => salesReceipts.fold<Decimal>(
    Decimal.zero,
    (previousValue, element) => previousValue + Decimal.parse(element.discount),
  );

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
