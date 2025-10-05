import 'package:admin_fribe/models/sales_receipt_model.dart';
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
