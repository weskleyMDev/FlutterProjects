import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:localdb/blocs/edit_todo/edit_todo_bloc.dart';
import 'package:localdb/blocs/sync_todos/sync_todos_bloc.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/database/local_db/todo_dao.dart';
import 'package:localdb/models/todo_model.dart';

class EditTodoScreen extends StatelessWidget {
  const EditTodoScreen({super.key, this.initialTodo});

  final TodoModel? initialTodo;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => EditTodoBloc(
        todoDao: RepositoryProvider.of<TodoDao>(context),
        initialTodo: initialTodo,
      ),
      child: const EditTodoView(),
    );
  }
}

class EditTodoView extends StatelessWidget {
  const EditTodoView({super.key});

  @override
  Widget build(BuildContext context) {
    final editTodoBloc = BlocProvider.of<EditTodoBloc>(context);
    final todosBloc = BlocProvider.of<TodoViewBloc>(context);
    final syncTodosBloc = BlocProvider.of<SyncTodosBloc>(context);
    void safePop() {
      if (Navigator.of(context).canPop()) {
        Navigator.of(context).pop();
      }
    }

    return BlocConsumer<EditTodoBloc, EditTodoState>(
      listener: (context, state) {
        if (state.status == FormzSubmissionStatus.success) {
          Future.delayed(const Duration(milliseconds: 150), () {
            safePop();
            editTodoBloc.add(const ResetEditTodoState());
            todosBloc.add(const LoadTodoViewEvent());
            syncTodosBloc.add(const GetSyncedCountEvent());
          });
        } else if (state.status == FormzSubmissionStatus.failure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage ?? 'Submission Failed')),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(state.isNewTodo ? 'Create Todo' : 'Edit Todo'),
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: TextFormField(
                      key: const ValueKey('editTitleTodo_textField'),
                      initialValue: state.titleInput.value,
                      onChanged: (value) =>
                          editTodoBloc.add(TitleInputChanged(value.trim())),
                      decoration: InputDecoration(
                        labelText: 'Title',
                        border: const OutlineInputBorder(),
                        errorText: state.titleInputError,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextFormField(
                      key: const ValueKey('editDescriptionTodo_textField'),
                      initialValue: state.descriptionInput.value,
                      onChanged: (value) => editTodoBloc.add(
                        DescriptionInputChanged(value.trim()),
                      ),
                      decoration: InputDecoration(
                        labelText: 'Description',
                        border: const OutlineInputBorder(),
                        errorText: state.descriptionInputError,
                      ),
                      maxLines: 3,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: state.isFormValid
                        ? () => editTodoBloc.add(const TodoSubmitted())
                        : null,
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
