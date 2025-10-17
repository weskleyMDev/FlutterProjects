part of 'update_amount_bloc.dart';

sealed class UpdateAmountEvent extends Equatable {
  const UpdateAmountEvent();

  @override
  List<Object?> get props => [];
}

final class AmountInputChanged extends UpdateAmountEvent {
  const AmountInputChanged(this.amount);

  final String amount;

  @override
  List<Object?> get props => [amount];
}

final class UpdateAmountSubmitted extends UpdateAmountEvent {
  const UpdateAmountSubmitted(this.productId);

  final String productId;

  @override
  List<Object?> get props => [productId];
}
