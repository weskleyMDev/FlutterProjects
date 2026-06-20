part of 'logs_bloc.dart';

enum LogsStatus { initial, loading, success, failure }

final class LogsState extends Equatable {
  final List<LogModel> logs;
  final LogsStatus status;
  final String? errorMessage;
  final String productId;
  final LogAction? selectedAction;

  const LogsState({
    this.logs = const [],
    this.status = LogsStatus.initial,
    this.errorMessage,
    required this.productId,
    this.selectedAction,
  });

  LogsState copyWith({
    List<LogModel>? logs,
    LogsStatus? status,
    String? errorMessage,
    bool clearErrorMessage = false,
    String? productId,
    LogAction? selectedAction,
    bool clearSelectedAction = false,
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
    );
  }

  @override
  List<Object?> get props => [
    logs,
    status,
    errorMessage,
    productId,
    selectedAction,
  ];
}
