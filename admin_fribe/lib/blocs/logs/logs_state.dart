part of 'logs_bloc.dart';

enum LogsStatus { initial, loading, success, failure }

enum LogsMode { product, general }

final class LogsState extends Equatable {
  final List<LogViewModel> logs;
  final LogsStatus status;
  final String? errorMessage;
  final String? productId;
  final LogAction? selectedAction;
  final LogsMode mode;

  const LogsState({
    this.logs = const [],
    this.status = LogsStatus.initial,
    this.errorMessage,
    this.productId,
    this.selectedAction,
    this.mode = LogsMode.general,
  });

  LogsState copyWith({
    List<LogViewModel>? logs,
    LogsStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? productId,
    LogAction? selectedAction,
    bool clearSelectedAction = false,
    LogsMode? mode,
  }) {
    return LogsState(
      logs: logs ?? this.logs,
      status: status ?? this.status,
      errorMessage: clearErrorMessage
          ? null
          : errorMessage ?? this.errorMessage,
      productId: productId ?? this.productId,
      selectedAction: clearSelectedAction
          ? null
          : selectedAction ?? this.selectedAction,
      mode: mode ?? this.mode,
    );
  }

  @override
  List<Object?> get props => [
    logs,
    status,
    errorMessage,
    productId,
    selectedAction,
    mode,
  ];
}
