part of 'receipt_bloc.dart';

sealed class ReceiptEvent extends Equatable {
  const ReceiptEvent();

  @override
  List<Object?> get props => [];
}

final class CreateReceipt extends ReceiptEvent {
  final ReceiptModel receipt;

  const CreateReceipt(this.receipt);

  @override
  List<Object?> get props => [receipt];
}

final class CreatePendingReceipt extends ReceiptEvent {
  final ReceiptModel receipt;
  final String client;

  const CreatePendingReceipt(this.receipt, this.client);

  @override
  List<Object?> get props => [receipt, client];
}

final class ReceiptsSubscribedRequest extends ReceiptEvent {
  const ReceiptsSubscribedRequest();
}
