part of 'logs_bloc.dart';

sealed class LogsEvent extends Equatable {
  const LogsEvent();

  @override
  List<Object?> get props => [];
}

final class OpenLogsScreen extends LogsEvent {
  final String? productId;

  const OpenLogsScreen({this.productId});

  @override
  List<Object?> get props => [productId];
}

final class SelectLogAction extends LogsEvent {
  final LogAction action;

  const SelectLogAction(this.action);

  @override
  List<Object?> get props => [action];
}
