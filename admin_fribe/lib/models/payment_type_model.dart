import 'dart:convert';

import 'package:equatable/equatable.dart';

final class PaymentType extends Equatable {
  final String type;
  final String value;

  const PaymentType._({
    required this.type,
    required this.value,
  });

  factory PaymentType.initial() =>
      const PaymentType._(type: '', value: '');

  PaymentType copyWith({
    String Function()? type,
    String Function()? value,
  }) {
    return PaymentType._(
      type: type?.call() ?? this.type,
      value: value?.call() ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'type': type, 'value': value};
  }

  factory PaymentType.fromMap(Map<String, dynamic> map) {
    return PaymentType._(
      type: map['type'] as String,
      value: map['value'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentType.fromJson(String source) =>
      PaymentType.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [type, value];
}
