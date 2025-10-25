import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/database/remote_db/remote_db.dart';
import 'package:localdb/models/todo_model.dart';

final class TodoRepository {
  const TodoRepository({
    required TodoDao todoDao,
    required RemoteDb remoteDb,
  })  : _todoDao = todoDao,
        _remoteDb = remoteDb;

  final TodoDao _todoDao;
  final RemoteDb _remoteDb;

  Future<void> syncTodoToFirestore(TodoModel todo) async {
    await _remoteDb.addTodo(todo);
    await _todoDao.updateTodo(
      todo: todo.copyWith(needsSync: false),
    );
  }

  Future<void> syncAllPending() async {
    final unsynced = await _todoDao.getTodosNeedingSync();
    for (final todo in unsynced) {
      await syncTodoToFirestore(todo);
    }
  }
}
