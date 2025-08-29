import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/report/report_event.dart';
import 'package:form_bloc/blocs/report/report_state.dart';

final class ReportBloc extends Bloc<ReportEvent, ReportState> {
  StreamSubscription? _subscription;
  ReportBloc() : super(ReportInitialState()) {
    on<FetchReportsEvent>(_onFetchReports);
    on<AddReportEvent>(_onAddReport);
    on<RemoveReportEvent>(_onRemoveReport);
    on<UpdateReportEvent>(_onUpdateReport);
    on<RefreshReportsEvent>(_onRefreshReports);
  }

  FutureOr<void> _onFetchReports(
    FetchReportsEvent event,
    Emitter<ReportState> emit,
  ) {}

  FutureOr<void> _onAddReport(
    AddReportEvent event,
    Emitter<ReportState> emit,
  ) {}

  FutureOr<void> _onRemoveReport(
    RemoveReportEvent event,
    Emitter<ReportState> emit,
  ) {}

  FutureOr<void> _onUpdateReport(
    UpdateReportEvent event,
    Emitter<ReportState> emit,
  ) {}

  FutureOr<void> _onRefreshReports(
    RefreshReportsEvent event,
    Emitter<ReportState> emit,
  ) {
    emit(ReportLoadedState(reports: event.reports));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
