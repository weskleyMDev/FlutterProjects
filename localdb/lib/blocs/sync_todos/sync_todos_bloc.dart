import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localdb/repositories/todo_repository.dart';

part 'sync_todos_event.dart';
part 'sync_todos_state.dart';

class SyncTodosBloc extends Bloc<SyncTodosEvent, SyncTodosState> {
  final TodoRepository _todoRepository;
  SyncTodosBloc({required TodoRepository todoRepository})
    : _todoRepository = todoRepository,
      super(SyncTodosState.initial()) {
    on<StartSyncTodosEvent>(_onStartSyncTodos);
    on<GetSyncedCountEvent>(_onGetSyncedCount);
    on<ResetSyncTodosStateEvent>(_onResetSyncTodosState);
  }

  Future<void> _onStartSyncTodos(
    StartSyncTodosEvent event,
    Emitter<SyncTodosState> emit,
  ) async {
    final unsynced = await _todoRepository.getTodosNeedingSyncCount();
    if (unsynced == 0) return;
    emit(
      state.copyWith(status: SyncTodosStatus.syncing, clearSnackMessage: true),
    );
    try {
      final result = await _todoRepository.syncAllPending();
      if (result.failureCount == 0 && result.successCount > 0) {
        emit(
          state.copyWith(
            status: SyncTodosStatus.success,
            snackMessage: 'All todos synced successfully!',
          ),
        );
      } else if (result.failureCount > 0 && result.successCount > 0) {
        emit(
          state.copyWith(
            status: SyncTodosStatus.partial,
            snackMessage:
                '${result.successCount} todos synced, '
                '${result.failureCount} failed.',
          ),
        );
      } else {
        emit(
          state.copyWith(
            status: SyncTodosStatus.failure,
            snackMessage: 'Failed to sync todos.',
          ),
        );
      }
    } catch (e) {
      emit(
        state.copyWith(
          status: SyncTodosStatus.failure,
          snackMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onGetSyncedCount(
    GetSyncedCountEvent event,
    Emitter<SyncTodosState> emit,
  ) async {
    final count = await _todoRepository.getTodosNeedingSyncCount();
    emit(state.copyWith(syncedCount: count));
  }

  void _onResetSyncTodosState(
    ResetSyncTodosStateEvent event,
    Emitter<SyncTodosState> emit,
  ) {
    emit(SyncTodosState.initial());
  }
}
