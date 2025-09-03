import 'dart:convert';

import 'package:admin_shop/models/cart_item.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

final class OrderModel extends Equatable {
  final String id;
  final String userId;
  final DateTime createdAt;
  final List<CartItem> products;
  final num total;
  final String? coupon;
  final num status;

  const OrderModel._({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.products,
    required this.total,
    required this.coupon,
    required this.status,
  });

  factory OrderModel.initial() => OrderModel._(
    id: '',
    userId: '',
    createdAt: DateTime.now(),
    products: const [],
    total: 0.0,
    coupon: null,
    status: 1,
  );

  OrderModel copyWith({
    String Function()? id,
    String Function()? userId,
    DateTime Function()? createdAt,
    List<CartItem> Function()? products,
    num Function()? total,
    String? Function()? coupon,
    num Function()? status,
  }) {
    return OrderModel._(
      id: id != null ? id() : this.id,
      userId: userId != null ? userId() : this.userId,
      createdAt: createdAt != null ? createdAt() : this.createdAt,
      products: products != null ? products() : this.products,
      total: total != null ? total() : this.total,
      coupon: coupon != null ? coupon() : this.coupon,
      status: status != null ? status() : this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'createdAt': Timestamp.fromDate(createdAt),
      'products': products.map((x) => x.toMap()).toList(),
      'total': total,
      'coupon': coupon,
      'status': status,
    };
  }

  factory OrderModel.fromMap(Map<String, dynamic> map) {
    return OrderModel._(
      id: map['id'] as String,
      userId: map['userId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      products: List<CartItem>.from(
        (map['products'] as List<dynamic>).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as num,
      coupon: map['coupon'] as String?,
      status: map['status'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [id, userId, createdAt, products, total, coupon, status];
  }
}
