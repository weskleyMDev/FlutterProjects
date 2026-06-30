import 'package:admin_fribe/logs/enum/log_action.dart';
import 'package:admin_fribe/models/log_view_model.dart';
import 'package:admin_fribe/repositories/logs/log_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'logs_event.dart';
part 'logs_state.dart';

final class LogsBloc extends Bloc<LogsEvent, LogsState> {
  final ILogRepository _logRepository;
  LogsBloc({required ILogRepository logRepository})
    : _logRepository = logRepository,
      super(LogsState(productId: '')) {
    on<OpenLogsScreen>(_onOpenLogScreen);
    on<SelectLogAction>(_onSelectLogAction);
  }

  Future<void> _onOpenLogScreen(
    OpenLogsScreen event,
    Emitter<LogsState> emit,
  ) async {
    emit(
      state.copyWith(
        productId: event.productId,
        mode: event.productId != null ? LogsMode.product : LogsMode.general,
        selectedAction: null,
        logs: [],
        status: LogsStatus.initial,
        clearErrorMessage: true,
      ),
    );
  }

  Future<void> _onSelectLogAction(
    SelectLogAction event,
    Emitter<LogsState> emit,
  ) async {
    emit(
      state.copyWith(
        selectedAction: event.action,
        status: LogsStatus.loading,
        clearErrorMessage: true,
      ),
    );

    try {
      final List<LogViewModel> logs;
      if (state.mode == LogsMode.product) {
        logs = await _logRepository.getLogsByProductID(
          productId: state.productId!,
          action: event.action,
        );
      } else {
        logs = await _logRepository.getLast20Logs(event.action);
      }

      emit(state.copyWith(logs: logs, status: LogsStatus.success));
    } catch (e) {
      emit(
        state.copyWith(status: LogsStatus.failure, errorMessage: e.toString()),
      );
    }
  }
}
