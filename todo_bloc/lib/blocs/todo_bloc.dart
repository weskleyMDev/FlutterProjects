import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
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
    await emit.forEach<QuerySnapshot<TodoModel>>(
      _todoRepository.todoStream,
      onData: (snapshot) {
        List<TodoModel> todos = [];
        for (var doc in snapshot.docChanges) {
          final data = doc.doc.data();
          if (data == null) continue;
          switch (doc.type) {
            case DocumentChangeType.added:
              todos.add(data);
              break;
            case DocumentChangeType.modified:
              final modifiedTodo = data;
              todos = todos.map((todo) {
                if (todo.id == modifiedTodo.id) return modifiedTodo;
                return todo;
              }).toList();
              break;
            case DocumentChangeType.removed:
              todos.removeWhere((todo) => todo.id == data.id);
              break;
          }
        }
        return state.copyWith(
          todos: () => todos,
          status: () => TodoStatus.loaded,
        );
      },
      onError: (error, _) {
        return state.copyWith(
          errorMessage: () => error.toString(),
          status: () => TodoStatus.error,
        );
      },
    );
  }

  Future<void> _onAddTodo(AddTodo event, Emitter<TodoState> emit) async {
    emit(state.copyWith(status: () => TodoStatus.loading));
    try {
      final newTodo = await _todoRepository.addTodo(event.text);
      emit(
        state.copyWith(
          todos: () => [...state.todos, newTodo],
          status: () => TodoStatus.loaded,
        ),
      );
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
      emit(
        state.copyWith(
          todos: () =>
              state.todos.where((todo) => todo.id != event.id).toList(),
          status: () => TodoStatus.loaded,
        ),
      );
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
