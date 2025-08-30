import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:form_bloc/models/report_model.dart';

enum ReportStatus { waiting, success, error, empty }

final class ReportState {
  final List<ReportModel> reports;
  final String text;
  final String userId;
  final ReportStatus? status;
  final Object? error;

  const ReportState._({
    required this.reports,
    required this.text,
    required this.userId,
    this.status,
    this.error,
  });

  factory ReportState.local() {
    return ReportState._(
      reports: const [],
      text: '',
      userId: '',
      status: null,
      error: null,
    );
  }

  ReportState copyWith({
    List<ReportModel>? reports,
    String? text,
    String? userId,
    ReportStatus? status,
    Object? error,
  }) {
    return ReportState._(
      reports: List.unmodifiable(reports ?? this.reports),
      text: text ?? this.text,
      userId: userId ?? this.userId,
      status: status ?? this.status,
      error: error ?? this.error,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'reports': reports.map((x) => x.toMap()).toList(),
      'text': text,
      'userId': userId,
    };
  }

  factory ReportState.fromMap(Map<String, dynamic> map) {
    return ReportState._(
      reports: List<ReportModel>.from(
        (map['reports'] as List).map<ReportModel>(
          (x) => ReportModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
      text: map['text'] as String,
      userId: map['userId'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportState.fromJson(String source) =>
      ReportState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'ReportState(reports: $reports, text: $text, userId: $userId, status: $status, error: $error)';
  }

  @override
  bool operator ==(covariant ReportState other) {
    if (identical(this, other)) return true;

    return listEquals(other.reports, reports) &&
        other.text == text &&
        other.userId == userId &&
        other.status == status &&
        other.error == error;
  }

  @override
  int get hashCode {
    return reports.hashCode ^
        text.hashCode ^
        userId.hashCode ^
        status.hashCode ^
        error.hashCode;
  }
}
