part of 'todo_view_bloc.dart';

enum TodoViewStatus { initial, loading, success, failure }

final class TodoViewState extends Equatable {
  const TodoViewState._({
    required this.todos,
    required this.status,
    required this.errorMessage,
  });

  factory TodoViewState.initial() => const TodoViewState._(
    todos: [],
    status: TodoViewStatus.initial,
    errorMessage: null,
  );

  final List<TodoModel> todos;
  final TodoViewStatus status;
  final String? errorMessage;

  List<TodoModel> get sortedTodos =>
      List<TodoModel>.of(todos)
        ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

  TodoViewState copyWith({
    List<TodoModel>? todos,
    TodoViewStatus? status,
    String? errorMessage,
    bool clearError = false,
  }) => TodoViewState._(
    todos: todos ?? this.todos,
    status: status ?? this.status,
    errorMessage: clearError ? null : (errorMessage ?? this.errorMessage),
  );

  @override
  List<Object?> get props => [todos, status, errorMessage];
}
