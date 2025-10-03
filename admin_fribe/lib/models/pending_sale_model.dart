import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:equatable/equatable.dart';

final class PendingSaleModel extends Equatable {
  final String id;
  final List<SalesReceipt> receipts;

  const PendingSaleModel._({required this.id, required this.receipts});

  factory PendingSaleModel.empty() =>
      const PendingSaleModel._(id: '', receipts: <SalesReceipt>[]);

  PendingSaleModel copyWith({
    String Function()? id,
    List<SalesReceipt> Function()? receipts,
  }) => PendingSaleModel._(
    id: id?.call() ?? this.id,
    receipts: receipts?.call() ?? this.receipts,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, receipts];
}
