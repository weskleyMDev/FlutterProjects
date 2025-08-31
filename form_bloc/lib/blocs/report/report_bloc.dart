import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/models/report_model.dart';
import 'package:form_bloc/repositories/report/ireport_repository.dart';

part 'report_event.dart';
part 'report_state.dart';

final class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final IReportRepository _reportRepository;
  ReportBloc(this._reportRepository) : super(ReportState.local()) {
    on<SetTextEvent>(_onSetTextEvent);
    on<SaveReportEvent>(_onSaveReportEvent);
    on<RemoveReportEvent>(_onRemoveReportEvent);
    on<StartReportsStreamEvent>(_onStartReportsStreamEvent);
  }

  FutureOr<void> _onSetTextEvent(
    SetTextEvent event,
    Emitter<ReportState> emit,
  ) {
    emit(state.copyWith(text: () => event.text));
  }

  FutureOr<void> _onSaveReportEvent(
    SaveReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      final text = state.text;
      if (text.isEmpty) return;
      final report = ReportModel.local().copyWith(
        text: () => text,
        userId: () => event.userId,
      );
      emit(state.copyWith(status: () => ReportStatus.waiting));
      await _reportRepository.addReport(report);
      emit(state.copyWith(status: () => ReportStatus.success, text: () => ''));
    } catch (e) {
      emit(
        state.copyWith(
          status: () => ReportStatus.error,
          error: () =>
              e is FirebaseException ? e.message! : 'Erro ao salvar relatório',
        ),
      );
    }
  }

  FutureOr<void> _onStartReportsStreamEvent(
    StartReportsStreamEvent event,
    Emitter<ReportState> emit,
  ) async {
    await emit.forEach<List<ReportModel>>(
      _reportRepository.getReports(event.userId),
      onData: (reports) => state.copyWith(reports: () => reports),
      onError: (_, _) =>
          state.copyWith(error: () => 'Erro ao carregar relatórios'),
    );
  }

  Future<void> _onRemoveReportEvent(
    RemoveReportEvent event,
    Emitter<ReportState> emit,
  ) async {
    try {
      emit(state.copyWith(status: () => ReportStatus.waiting));
      await _reportRepository.removeReport(event.report);
      emit(state.copyWith(status: () => ReportStatus.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: () => ReportStatus.error,
          error: () =>
              e is FirebaseException ? e.message! : 'Erro ao remover relatório',
        ),
      );
    }
  }
}
