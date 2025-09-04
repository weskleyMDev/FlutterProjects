part of 'todo_bloc.dart';

sealed class TodoEvent extends Equatable {
  const TodoEvent();

  @override
  List<Object> get props => [];
}

final class FetchTodos extends TodoEvent {
  const FetchTodos();
  @override
  List<Object> get props => [];
}

final class AddTodo extends TodoEvent {
  const AddTodo(this.text);
  final String text;
  @override
  List<Object> get props => [text];
}

final class DeleteTodo extends TodoEvent {
  const DeleteTodo(this.id);
  final String id;
  @override
  List<Object> get props => [id];
}
