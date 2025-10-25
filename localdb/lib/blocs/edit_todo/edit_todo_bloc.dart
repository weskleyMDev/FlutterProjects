import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:localdb/blocs/edit_todo/input/description_input.dart';
import 'package:localdb/blocs/edit_todo/input/title_input.dart';
import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/models/todo_model.dart';

part 'edit_todo_event.dart';
part 'edit_todo_state.dart';

final class EditTodoBloc extends Bloc<EditTodoEvent, EditTodoState> {
  EditTodoBloc({required TodoDao todoDao, required TodoModel? initialTodo})
    : _todoDao = todoDao,
      super(
        initialTodo != null
            ? EditTodoState.fromTodoModel(initialTodo)
            : EditTodoState.initial(),
      ) {
    on<TitleInputChanged>(_onTitleInputChanged);
    on<DescriptionInputChanged>(_onDescriptionInputChanged);
    on<TodoSubmitted>(_onTodoSubmitted);
    on<ResetEditTodoState>(_onResetEditTodoState);
  }

  final TodoDao _todoDao;

  void _onTitleInputChanged(
    TitleInputChanged event,
    Emitter<EditTodoState> emit,
  ) {
    final titleInput = TitleInput.dirty(event.title);
    emit(state.copyWith(titleInput: titleInput));
  }

  void _onDescriptionInputChanged(
    DescriptionInputChanged event,
    Emitter<EditTodoState> emit,
  ) {
    final descriptionInput = DescriptionInput.dirty(event.description);
    emit(state.copyWith(descriptionInput: descriptionInput));
  }

  Future<void> _onTodoSubmitted(
    TodoSubmitted event,
    Emitter<EditTodoState> emit,
  ) async {
    if (!state.isFormValid) return;
    emit(
      state.copyWith(
        status: FormzSubmissionStatus.inProgress,
        clearErrorMessage: true,
      ),
    );
    try {
      final newTodo = (state.initialTodo ?? TodoModel.empty()).copyWith(
        title: state.titleInput.value,
        description: state.descriptionInput.value,
        needsSync: true,
      );
      if (state.initialTodo == null) {
        await _todoDao.insertTodo(todo: newTodo);
      } else {
        await _todoDao.updateTodo(todo: newTodo);
      }
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.success,
          clearErrorMessage: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzSubmissionStatus.failure,
          errorMessage: 'An error occurred while saving the todo: $e',
        ),
      );
    }
  }

  void _onResetEditTodoState(
    ResetEditTodoState event,
    Emitter<EditTodoState> emit,
  ) {
    emit(EditTodoState.initial());
  }
}
