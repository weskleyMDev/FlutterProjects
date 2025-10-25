import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/models/todo_model.dart';

part 'todo_view_event.dart';
part 'todo_view_state.dart';

class TodoViewBloc extends Bloc<TodoViewEvent, TodoViewState> {
  TodoViewBloc({required TodoDao todoDao})
    : _todoDao = todoDao,
      super(TodoViewState.initial()) {
    on<LoadTodoViewEvent>(_onLoadTodoView);
    on<CheckCompletedChange>(_onCheckCompletedChange);
  }

  final TodoDao _todoDao;

  Future<void> _onLoadTodoView(
    LoadTodoViewEvent event,
    Emitter<TodoViewState> emit,
  ) async {
    emit(state.copyWith(status: TodoViewStatus.loading));
    try {
      final todos = await _todoDao.getAllTodos();
      emit(state.copyWith(status: TodoViewStatus.success, todos: todos));
    } catch (e) {
      emit(
        state.copyWith(
          status: TodoViewStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onCheckCompletedChange(
    CheckCompletedChange event,
    Emitter<TodoViewState> emit,
  ) async {
    try {
      final todoIndex = state.todos.indexWhere(
        (todo) => todo.id == event.todoId,
      );
      if (todoIndex == -1) return;
      final updatedTodo = state.todos[todoIndex].copyWith(
        isCompleted: event.isCompleted,
      );
      await _todoDao.updateTodo(todo: updatedTodo);
      final updatedTodos = List<TodoModel>.from(state.todos);
      updatedTodos[todoIndex] = updatedTodo;
      emit(state.copyWith(todos: updatedTodos, clearError: true));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    }
  }
}
