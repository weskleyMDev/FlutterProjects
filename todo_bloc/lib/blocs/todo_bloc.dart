import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/models/todo_model.dart';
import 'package:todo/repositories/todo_repository.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final ITodoRepository _todoRepository;
  TodoBloc(this._todoRepository) : super(TodoState.initial()) {
    on<FetchTodos>(_onFetchTodos);
    on<AddTodo>(_onAddTodo);
    on<DeleteTodo>(_onDeleteTodo);
  }

  Future<void> _onFetchTodos(FetchTodos event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: () => TodoStatus.loading));
    await emit.forEach<List<TodoModel>>(
      _todoRepository.todoStream,
      onData: (data) =>
          state.copyWith(todos: () => data, status: () => TodoStatus.loaded),
      onError: (error, _) {
        return state.copyWith(
          errorMessage: () => error is FirebaseException
              ? error.message ?? 'Unknown error!'
              : error.toString(),
          status: () => TodoStatus.error,
        );
      },
    );
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: () => TodoStatus.loading));
    try {
      await _todoRepository.addTodo(event.text);
      emit(state.copyWith(status: () => TodoStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: () => e.toString(),
          status: () => TodoStatus.error,
        ),
      );
    }
  }

  Future<void> _onDeleteTodo(DeleteTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: () => TodoStatus.loading));
    try {
      await _todoRepository.deleteTodoById(event.id);
      emit(state.copyWith(status: () => TodoStatus.loaded));
    } catch (e) {
      emit(
        state.copyWith(
          errorMessage: () => e.toString(),
          status: () => TodoStatus.error,
        ),
      );
    }
  }
}
