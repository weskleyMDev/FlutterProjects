part of 'todo_view_bloc.dart';

sealed class TodoViewEvent extends Equatable {
  const TodoViewEvent();

  @override
  List<Object?> get props => [];
}

final class LoadTodoViewEvent extends TodoViewEvent {
  const LoadTodoViewEvent();

  @override
  List<Object?> get props => [];
}

final class CheckCompletedChange extends TodoViewEvent {
  const CheckCompletedChange({required this.todoId, required this.isCompleted});

  final String todoId;
  final bool isCompleted;

  @override
  List<Object?> get props => [todoId, isCompleted];
}
