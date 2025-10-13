import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

final class ReportDataModel extends Equatable {
  final String title;
  final Decimal total;
  final Color color;
  final IconData icon;

  const ReportDataModel._({
    required this.title,
    required this.total,
    required this.color,
    required this.icon,
  });

  factory ReportDataModel.empty() => ReportDataModel._(
    title: '',
    total: Decimal.zero,
    color: Colors.grey,
    icon: Icons.help_outline,
  );

  ReportDataModel copyWith({
    String? title,
    Decimal? total,
    Color? color,
    IconData? icon,
  }) {
    return ReportDataModel._(
      title: title ?? this.title,
      total: total ?? this.total,
      color: color ?? this.color,
      icon: icon ?? this.icon,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [title, total, color, icon];
}
