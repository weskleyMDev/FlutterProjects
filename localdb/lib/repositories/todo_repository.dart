import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/database/remote_db/remote_db.dart';
import 'package:localdb/models/sync_result_model.dart';
import 'package:localdb/models/todo_model.dart';

final class TodoRepository {
  const TodoRepository({required TodoDao todoDao, required RemoteDb remoteDb})
    : _todoDao = todoDao,
      _remoteDb = remoteDb;

  final TodoDao _todoDao;
  final RemoteDb _remoteDb;

  Future<int> getTodosNeedingSyncCount() async {
    final List<TodoModel> unsyncedCount = await _todoDao.getTodosNeedingSync();
    return unsyncedCount.length;
  }

  Future<void> syncTodoToFirestore(List<TodoModel> todos) async {
    await _remoteDb.addTodos(todos);
    await Future.wait(
      todos.map(
        (todo) => _todoDao.updateTodo(todo: todo.copyWith(needsSync: false)),
      ),
    );
  }

  Future<SyncResultModel> syncAllPending({
    int chunkSize = 20,
    int maxRetries = 3,
    Duration retryDelay = const Duration(seconds: 2),
  }) async {
    final unsynced = await _todoDao.getTodosNeedingSync();
    if (unsynced.isEmpty) return SyncResultModel.empty();
    int successCount = 0;
    final List<TodoModel> failedTodos = [];
    for (var i = 0; i < unsynced.length; i += chunkSize) {
      final chunk = unsynced.skip(i).take(chunkSize).toList();
      var attempt = 0;
      bool success = false;
      while (attempt < maxRetries && !success) {
        try {
          attempt++;
          await syncTodoToFirestore(chunk);
          success = true;
          successCount += chunk.length;
        } catch (_) {
          if (attempt < maxRetries) {
            await Future.delayed(retryDelay);
          } else {
            failedTodos.addAll(chunk);
          }
        }
      }
    }
    return SyncResultModel(
      successCount: successCount,
      failureCount: failedTodos.length,
      failedTodos: failedTodos,
    );
  }
}
