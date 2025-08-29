import 'package:todo/models/todo_model.dart';

sealed class TodoState {}

class TodoInitial extends TodoState {}

class TodoLoading extends TodoState {}

class TodoLoaded extends TodoState {
  final List<TodoModel> todos;
  TodoLoaded({required this.todos});
}

class TodoError extends TodoState {
  final Exception error;
  TodoError({required this.error});
}
