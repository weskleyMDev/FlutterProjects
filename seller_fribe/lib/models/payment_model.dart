import 'package:equatable/equatable.dart';

final class PaymentModel extends Equatable {
  final String type;
  final String value;

  const PaymentModel._({this.type = '', this.value = ''});

  const PaymentModel.empty() : this._();

  PaymentModel copyWith({String? Function()? type, String? Function()? value}) {
    return PaymentModel._(
      type: type?.call() ?? this.type,
      value: value?.call() ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {'type': type, 'value': value};
  }

  factory PaymentModel.fromMap(Map<String, dynamic> map) {
    return PaymentModel._(type: map['type'] ?? '', value: map['value'] ?? '');
  }

  @override
  bool? get stringify => true;

  @override
  List<Object> get props => [type, value];
}
