import 'package:todo/models/todo_model.dart';

sealed class TodoEvent {}

class FetchTodos extends TodoEvent {}

class AddTodo extends TodoEvent {
  final String text;
  AddTodo({required this.text});
}

class DeleteTodo extends TodoEvent {
  final String id;
  DeleteTodo({required this.id});
}

class TodosUpdated extends TodoEvent {
  final List<TodoModel> todos;
  TodosUpdated(this.todos);
}
