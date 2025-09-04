part of 'todo_bloc.dart';

enum TodoStatus { initial, loading, loaded, error }

final class TodoState extends Equatable {
  final List<TodoModel> todos;
  final String text;
  final TodoStatus status;
  final String errorMessage;

  const TodoState._({
    required this.todos,
    required this.text,
    required this.status,
    required this.errorMessage,
  });

  factory TodoState.initial() => const TodoState._(
    todos: [],
    text: '',
    status: TodoStatus.initial,
    errorMessage: '',
  );

  TodoState copyWith({
    List<TodoModel> Function()? todos,
    String Function()? text,
    TodoStatus Function()? status,
    String Function()? errorMessage,
  }) => TodoState._(
    todos: todos?.call() ?? this.todos,
    text: text?.call() ?? this.text,
    status: status?.call() ?? this.status,
    errorMessage: errorMessage?.call() ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [todos, text, status, errorMessage];
}
