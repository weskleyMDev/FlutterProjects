import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/blocs/todo_event.dart';
import 'package:todo/blocs/todo_state.dart';
import 'package:todo/repositories/itodo_repository.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoRepository _todoRepository;
  StreamSubscription? _subscription;
  TodoBloc(this._todoRepository) : super(TodoInitial()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
    on<TodosUpdated>(_onTodosUpdated);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    await _subscription?.cancel();
    _subscription = _todoRepository.todoStream.listen(
      (data) => add(TodosUpdated(data)),
      onError: (e) => emit(TodoError(error: e)),
    );
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoRepository.addTodo(event.text);
    } catch (e) {
      emit(
        TodoError(error: e is Exception ? e : Exception('Unknown error: $e')),
      );
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(TodoLoading());
    try {
      await _todoRepository.deleteTodoById(event.id);
    } catch (e) {
      emit(
        TodoError(error: e is Exception ? e : Exception('Unknown error: $e')),
      );
    }
  }

  void _onTodosUpdated(TodosUpdated event, Emitter<TodoState> emit) {
    emit(TodoLoaded(todos: event.todos));
  }

  @override
  Future<void> close() async {
    await _subscription?.cancel();
    return super.close();
  }
}
