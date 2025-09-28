part of 'receipt_bloc.dart';

enum ReceiptStatus { initial, loading, success, failure }

final class ReceiptState extends Equatable {
  final List<ReceiptModel> receipts;
  final ReceiptStatus status;
  final String? errorMessage;
  const ReceiptState._({
    this.receipts = const [],
    this.status = ReceiptStatus.initial,
    this.errorMessage,
  });

  const ReceiptState.initial() : this._();

  ReceiptState copyWith({
    List<ReceiptModel> Function()? receipts,
    ReceiptStatus Function()? status,
    String? Function()? errorMessage,
  }) => ReceiptState._(
    receipts: receipts?.call() ?? this.receipts,
    status: status?.call() ?? this.status,
    errorMessage: errorMessage?.call() ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [receipts, status, errorMessage];
}
