part of 'sync_todos_bloc.dart';

sealed class SyncTodosEvent extends Equatable {
  const SyncTodosEvent();

  @override
  List<Object> get props => [];
}

final class StartSyncTodosEvent extends SyncTodosEvent {
  const StartSyncTodosEvent();

  @override
  List<Object> get props => [];
}

final class ResetSyncTodosStateEvent extends SyncTodosEvent {
  const ResetSyncTodosStateEvent();

  @override
  List<Object> get props => [];
}

final class GetSyncedCountEvent extends SyncTodosEvent {
  const GetSyncedCountEvent();

  @override
  List<Object> get props => [];
}