// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class Payment {
  final String type;
  final String value;

  Payment({required this.type, required this.value});

  Payment copyWith({String? type, String? value}) {
    return Payment(type: type ?? this.type, value: value ?? this.value);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{'type': type, 'value': value};
  }

  factory Payment.fromMap(Map<String, dynamic> map) {
    return Payment(type: map['type'] as String, value: map['value'] as String);
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'Payment(type: $type, value: $value)';

  @override
  bool operator ==(covariant Payment other) {
    if (identical(this, other)) return true;

    return other.type == type && other.value == value;
  }

  @override
  int get hashCode => type.hashCode ^ value.hashCode;
}
