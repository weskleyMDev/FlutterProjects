import 'package:localdb/database/local_db/local_db.dart';
import 'package:localdb/models/todo_model.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

final class TodoDao {
  Future<int> insertTodo({required TodoModel todo}) async {
    final db = await LocalDB.getDatabase();
    return await db.insert(
      'todos',
      todo.toSqlite(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> updateTodo({required TodoModel todo}) async {
    final db = await LocalDB.getDatabase();
    return await db.update(
      'todos',
      todo.toSqlite(),
      where: 'id = ?',
      whereArgs: [todo.id],
    );
  }

  Future<List<TodoModel>> getAllTodos() async {
    final db = await LocalDB.getDatabase();
    final todosData = await db.query('todos');
    return todosData.map((data) => TodoModel.fromSqlite(data)).toList();
  }

  Future<List<TodoModel>> getTodosNeedingSync() async {
    final db = await LocalDB.getDatabase();
    final todosData = await db.query(
      'todos',
      where: 'needsSync = ?',
      whereArgs: [1],
    );
    return todosData.map((data) => TodoModel.fromSqlite(data)).toList();
  }
}
