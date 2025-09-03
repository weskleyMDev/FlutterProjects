// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:shop_v2/models/cart/cart_item.dart';

class OrderModel {
  final String id;
  final String userId;
  final DateTime createdAt;
  final List<CartItem> products;
  final num total;
  final String? coupon;
  final num status;

  OrderModel({
    required this.id,
    required this.userId,
    required this.createdAt,
    required this.products,
    required this.total,
    required this.coupon,
    this.status = 1,
  });

  OrderModel copyWith({
    String? id,
    String? userId,
    DateTime? createdAt,
    List<CartItem>? products,
    num? total,
    String? coupon,
    num? status,
  }) {
    return OrderModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      createdAt: createdAt ?? this.createdAt,
      products: products ?? this.products,
      total: total ?? this.total,
      coupon: coupon ?? this.coupon,
      status: status ?? this.status,
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
    return OrderModel(
      id: map['id'] as String,
      userId: map['userId'] as String,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      products: List<CartItem>.from(
        (map['products'] as List).map<CartItem>(
          (x) => CartItem.fromMap(x as Map<String, dynamic>),
        ),
      ),
      total: map['total'] as num,
      coupon: map['coupon'] != null ? map['coupon'] as String : null,
      status: map['status'] as num,
    );
  }

  String toJson() => json.encode(toMap());

  factory OrderModel.fromJson(String source) =>
      OrderModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'OrderModel(id: $id, userId: $userId, createdAt: $createdAt, products: $products, total: $total, coupon: $coupon, status: $status)';
  }

  @override
  bool operator ==(covariant OrderModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.userId == userId &&
        other.createdAt == createdAt &&
        listEquals(other.products, products) &&
        other.total == total &&
        other.coupon == coupon &&
        other.status == status;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        createdAt.hashCode ^
        products.hashCode ^
        total.hashCode ^
        coupon.hashCode ^
        status.hashCode;
  }
}
