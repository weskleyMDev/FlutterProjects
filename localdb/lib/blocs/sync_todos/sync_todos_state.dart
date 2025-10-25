part of 'sync_todos_bloc.dart';

enum SyncTodosStatus { initial, syncing, success, partial, failure }

final class SyncTodosState extends Equatable {
  const SyncTodosState._({
    required this.status,
    required this.snackMessage,
    required this.syncedCount,
  });

  factory SyncTodosState.initial() => const SyncTodosState._(
    status: SyncTodosStatus.initial,
    snackMessage: null,
    syncedCount: 0,
  );

  final int syncedCount;
  final SyncTodosStatus status;
  final String? snackMessage;

  bool get isSyncing => status == SyncTodosStatus.syncing;

  SyncTodosState copyWith({
    int? syncedCount,
    SyncTodosStatus? status,
    String? snackMessage,
    bool clearSnackMessage = false,
  }) => SyncTodosState._(
    syncedCount: syncedCount ?? this.syncedCount,
    status: status ?? this.status,
    snackMessage: clearSnackMessage
        ? null
        : (snackMessage ?? this.snackMessage),
  );

  @override
  List<Object?> get props => [status, snackMessage, syncedCount];
}
