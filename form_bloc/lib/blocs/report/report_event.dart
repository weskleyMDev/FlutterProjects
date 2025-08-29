import 'package:form_bloc/models/report_model.dart';

sealed class ReportEvent {}

final class FetchReportsEvent extends ReportEvent {}

final class AddReportEvent extends ReportEvent {
  final ReportModel report;

  AddReportEvent({required this.report});
}

final class RemoveReportEvent extends ReportEvent {
  final ReportModel report;

  RemoveReportEvent({required this.report});
}

final class UpdateReportEvent extends ReportEvent {
  final ReportModel report;

  UpdateReportEvent({required this.report});
}

final class RefreshReportsEvent extends ReportEvent {
  final List<ReportModel> reports;

  RefreshReportsEvent({required this.reports});
}
