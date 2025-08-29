import 'package:form_bloc/models/report_model.dart';

sealed class ReportState {}

final class ReportInitialState extends ReportState {}

final class ReportLoadingState extends ReportState {}

final class ReportLoadedState extends ReportState {
  final List<ReportModel> reports;

  ReportLoadedState({required this.reports});
}

final class ReportErrorState extends ReportState {
  final Object error;

  ReportErrorState({required this.error});
}
