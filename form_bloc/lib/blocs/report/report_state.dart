part of 'report_bloc.dart';

enum ReportStatus { waiting, success, error, initial }

final class ReportState extends Equatable {
  final List<ReportModel> reports;
  final String text;
  final String userId;
  final ReportStatus status;
  final Object error;

  const ReportState._({
    required this.reports,
    required this.text,
    required this.userId,
    required this.status,
    required this.error,
  });

  factory ReportState.local() {
    return ReportState._(
      reports: const [],
      text: '',
      userId: '',
      status: ReportStatus.initial,
      error: '',
    );
  }

  ReportState copyWith({
    List<ReportModel> Function()? reports,
    String Function()? text,
    String Function()? userId,
    ReportStatus Function()? status,
    Object Function()? error,
  }) {
    return ReportState._(
      reports: reports != null ? reports() : this.reports,
      text: text != null ? text() : this.text,
      userId: userId != null ? userId() : this.userId,
      status: status != null ? status() : this.status,
      error: error != null ? error() : this.error,
    );
  }

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

  @override
  List<Object?> get props => [reports, text, userId, status, error];
}
