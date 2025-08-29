import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class ReportModel {
  final String id;
  final num total;
  final DateTime createdAt;

  ReportModel({required this.id, required this.total, required this.createdAt});

  ReportModel copyWith({String? id, num? total, DateTime? createdAt}) {
    return ReportModel(
      id: id ?? this.id,
      total: total ?? this.total,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'total': total,
      'createdAt': Timestamp.fromDate(createdAt),
    };
  }

  factory ReportModel.fromMap(Map<String, dynamic> map) {
    return ReportModel(
      id: map['id'] as String,
      total: map['total'] as num,
      createdAt: (map['createdAt'] as Timestamp).toDate(),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportModel.fromJson(String source) =>
      ReportModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() =>
      'ReportModel(id: $id, total: $total, createdAt: $createdAt)';

  @override
  bool operator ==(covariant ReportModel other) {
    if (identical(this, other)) return true;

    return other.id == id &&
        other.total == total &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ total.hashCode ^ createdAt.hashCode;
}
