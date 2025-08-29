import 'package:todo/models/todo_model.dart';

abstract class ITodoRepository {
  Stream<List<TodoModel>> get todoStream;
  Future<TodoModel> addTodo(String text);
  Future<void> deleteTodoById(String id);
}
