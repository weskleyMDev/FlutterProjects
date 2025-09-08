part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, loaded, error }

final class TodoState extends Equatable {
  final List<TodoModel> todos;
  final TodoStatus status;
  final String errorMessage;

  const TodoState._({
    required this.todos,
    required this.status,
    required this.errorMessage,
  });

  factory TodoState.initial() => const TodoState._(
    todos: [],
    status: TodoStatus.initial,
    errorMessage: '',
  );

  TodoState copyWith({
    List<TodoModel> Function()? todos,
    TodoStatus Function()? status,
    String Function()? errorMessage,
  }) => TodoState._(
    todos: todos?.call() ?? this.todos,
    status: status?.call() ?? this.status,
    errorMessage: errorMessage?.call() ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [todos, status, errorMessage];
}
