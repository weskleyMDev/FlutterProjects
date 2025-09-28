import 'package:equatable/equatable.dart';
import 'package:seller_fribe/models/receipt_model.dart';

final class PendingReceiptModel extends Equatable {
  final String id;
  final List<ReceiptModel> receipts;

  const PendingReceiptModel._({this.id = '', this.receipts = const []});

  factory PendingReceiptModel.empty() => const PendingReceiptModel._();

  PendingReceiptModel copyWith({
    String Function()? id,
    List<ReceiptModel> Function()? receipts,
  }) {
    return PendingReceiptModel._(
      id: id?.call() ?? this.id,
      receipts: receipts?.call() ?? this.receipts,
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [id, receipts];
}
