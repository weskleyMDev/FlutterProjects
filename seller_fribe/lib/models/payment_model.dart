import 'package:equatable/equatable.dart';

final class PaymentModel extends Equatable {
  final String method;
  final String amount;

  const PaymentModel._({this.method = '', this.amount = ''});

  const PaymentModel.empty() : this._();

  PaymentModel copyWith({
    String? Function()? method,
    String? Function()? amount,
  }) {
    return PaymentModel._(
      method: method?.call() ?? this.method,
      amount: amount?.call() ?? this.amount,
    );
  }

  Map<String, dynamic> toMap() {
    return {'method': method, 'amount': amount};
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel._(
      method: map['method'] ?? '',
      amount: map['amount'] ?? '',
    );
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [method, amount];
}
