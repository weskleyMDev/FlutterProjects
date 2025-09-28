import 'package:equatable/equatable.dart';
import 'package:seller_fribe/models/cart_item_model.dart';
import 'package:seller_fribe/models/payment_model.dart';

final class ReceiptModel extends Equatable {
  final String id;
  final DateTime? createAt;
  final String discount;
  final String discountReason;
  final String shipping;
  final String tariffs;
  final String total;
  final List<PaymentModel> payments;
  final List<CartItemModel> cart;
  final bool status;

  const ReceiptModel._({
    this.id = '',
    this.createAt,
    this.discount = '',
    this.discountReason = '',
    this.shipping = '',
    this.tariffs = '',
    this.total = '',
    this.payments = const [],
    this.cart = const [],
    this.status = true,
  });

  const ReceiptModel.empty() : this._();

  ReceiptModel copyWith({
    String Function()? id,
    DateTime? Function()? createAt,
    String Function()? discount,
    String Function()? discountReason,
    String Function()? shipping,
    String Function()? tariffs,
    String Function()? total,
    List<PaymentModel> Function()? payments,
    List<CartItemModel> Function()? cart,
    bool Function()? status,
  }) => ReceiptModel._(
    id: id?.call() ?? this.id,
    createAt: createAt?.call() ?? this.createAt,
    discount: discount?.call() ?? this.discount,
    discountReason: discountReason?.call() ?? this.discountReason,
    shipping: shipping?.call() ?? this.shipping,
    tariffs: tariffs?.call() ?? this.tariffs,
    total: total?.call() ?? this.total,
    payments: payments?.call() ?? this.payments,
    cart: cart?.call() ?? this.cart,
    status: status?.call() ?? this.status,
  );

  Map<String, dynamic> toMap() => {
    'id': id,
    'createAt': createAt?.toIso8601String(),
    'discount': discount,
    'discountReason': discountReason,
    'shipping': shipping,
    'tariffs': tariffs,
    'total': total,
    'payments': payments.map((x) => x.toMap()).toList(),
    'cart': cart.map((x) => x.toMap()).toList(),
    'status': status,
  };

  factory ReceiptModel.fromMap(Map<String, dynamic> map) => ReceiptModel._(
    id: map['id'] ?? '',
    createAt: map['createAt'] != null ? DateTime.parse(map['createAt']) : null,
    discount: map['discount'] ?? '',
    discountReason: map['discountReason'] ?? '',
    shipping: map['shipping'] ?? '',
    tariffs: map['tariffs'] ?? '',
    total: map['total'] ?? '',
    payments: map['payments'] != null
        ? List<PaymentModel>.from(
            (map['payments'] as List<dynamic>).map<PaymentModel>(
              (x) => PaymentModel.fromMap(x as Map<String, dynamic>),
            ),
          )
        : [],
    cart: map['cart'] != null
        ? List<CartItemModel>.from(
            (map['cart'] as List<dynamic>).map<CartItemModel>(
              (x) => CartItemModel.fromMap(x as Map<String, dynamic>),
            ),
          )
        : [],
    status: map['status'] ?? true,
  );

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
    id,
    createAt,
    discount,
    discountReason,
    shipping,
    tariffs,
    total,
    payments,
    cart,
    status,
  ];
}
