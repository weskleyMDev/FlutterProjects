import 'package:equatable/equatable.dart';

final class PaymentModel extends Equatable {
  const PaymentModel({required this.method, required this.amount});

  final String method;
  final String amount;

  PaymentModel copyWith({
    String? Function()? method,
    String? Function()? amount,
  }) {
    return PaymentModel(
      method: method?.call() ?? this.method,
      amount: amount?.call() ?? this.amount,
    );
  }

  @override
  List<Object> get props => [method, amount];
}
