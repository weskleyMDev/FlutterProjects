import 'package:form_bloc/models/report_model.dart';

abstract interface class IReportRepository {
  Stream<List<ReportModel>> getReports();
  Future<void> addReport(ReportModel report);
  Future<void> removeReport(ReportModel report);
}
