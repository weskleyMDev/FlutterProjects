part of 'report_bloc.dart';

sealed class ReportEvent {}

final class SetTextEvent extends ReportEvent {
  final String text;

  SetTextEvent({required this.text});
}

final class SaveReportEvent extends ReportEvent {
  final String userId;
  SaveReportEvent(this.userId);
}

final class RemoveReportEvent extends ReportEvent {
  final ReportModel report;

  RemoveReportEvent({required this.report});
}

final class UpdateReportEvent extends ReportEvent {
  final ReportModel report;

  UpdateReportEvent({required this.report});
}

final class StartReportsStreamEvent extends ReportEvent {
  final String userId;
  StartReportsStreamEvent({required this.userId});
}

final class ClearFields extends ReportEvent {}
