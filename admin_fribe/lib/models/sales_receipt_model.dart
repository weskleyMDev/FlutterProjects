import 'dart:convert';

import 'package:admin_fribe/models/cart_item_model.dart';
import 'package:admin_fribe/models/payment_type_model.dart';
import 'package:equatable/equatable.dart';

final class SalesReceipt extends Equatable {
  final String id;
  final List<CartItem> cart;
  final DateTime createAt;
  final String discount;
  final String discountReason;
  final List<PaymentType> payments;
  final String shipping;
  final String tariffs;
  final String total;

  const SalesReceipt._({
    required this.id,
    required this.cart,
    required this.createAt,
    required this.discount,
    required this.discountReason,
    required this.payments,
    required this.shipping,
    required this.tariffs,
    required this.total,
  });

  factory SalesReceipt.initial() => SalesReceipt._(
    id: '',
    cart: [],
    createAt: DateTime.now(),
    discount: '0',
    discountReason: '',
    payments: [],
    shipping: '0',
    tariffs: '0',
    total: '0',
  );

  SalesReceipt copyWith({
    String Function()? id,
    List<CartItem> Function()? cart,
    DateTime Function()? createAt,
    String Function()? discount,
    String Function()? discountReason,
    List<PaymentType> Function()? payments,
    String Function()? shipping,
    String Function()? tariffs,
    String Function()? total,
  }) {
    return SalesReceipt._(
      id: id?.call() ?? this.id,
      cart: cart?.call() ?? this.cart,
      createAt: createAt?.call() ?? this.createAt,
      discount: discount?.call() ?? this.discount,
      discountReason: discountReason?.call() ?? this.discountReason,
      payments: payments?.call() ?? this.payments,
      shipping: shipping?.call() ?? this.shipping,
      tariffs: tariffs?.call() ?? this.tariffs,
      total: total?.call() ?? this.total,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cart': cart.map((x) => x.toMap()).toList(),
      'createAt': createAt.toIso8601String(),
      'discount': discount,
      'discountReason': discountReason,
      'payments': payments.map((x) => x.toMap()).toList(),
      'shipping': shipping,
      'tariffs': tariffs,
      'total': total,
    };
  }

  factory SalesReceipt.fromMap(Map<String, dynamic> map) {
    return SalesReceipt._(
      id: map['id'] as String,
      cart: List<CartItem>.from(
        (map['cart'] as List).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      createAt: DateTime.parse(map['createAt'] as String),
      discount: map['discount'] as String,
      discountReason: map['discountReason'] as String,
      payments: List<PaymentType>.from(
        (map['payments'] as List).map<PaymentType>(
          (x) => PaymentType.fromMap(x as Map<String, dynamic>),
        ),
      ),
      shipping: map['shipping'] as String,
      tariffs: map['tariffs'] as String,
      total: map['total'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory SalesReceipt.fromJson(String source) =>
      SalesReceipt.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      cart,
      createAt,
      discount,
      discountReason,
      payments,
      shipping,
      tariffs,
      total,
    ];
  }
}
