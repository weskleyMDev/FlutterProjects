part of 'todo_repository.dart';

abstract interface class ITodoRepository {
  Stream<List<TodoModel>> get todoStream;
  Future<TodoModel> addTodo(String text);
  Future<void> deleteTodoById(String id);
}
