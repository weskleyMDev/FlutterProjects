import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/models/todo_model.dart';
import 'package:localdb/utils/capitalize_text.dart';

class BuildTodoCard extends StatelessWidget {
  const BuildTodoCard({super.key, required this.todoId});

  final String todoId;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final dateFormat = DateFormat.yMd(locale).add_Hm();
    return BlocSelector<TodoViewBloc, TodoViewState, TodoModel?>(
      selector: (state) => state.todos.firstWhere(
        (todo) => todo.id == todoId,
        orElse: () => TodoModel.empty(),
      ),
      builder: (context, todo) {
        if (todo == null) {
          return const SizedBox.shrink();
        }
        return Card(
          key: ValueKey(todo.id),
          child: ListTile(
            leading: Checkbox(
              value: todo.isCompleted,
              onChanged: (value) => BlocProvider.of<TodoViewBloc>(context).add(
                CheckCompletedChange(
                  todoId: todo.id,
                  isCompleted: value ?? false,
                ),
              ),
            ),
            title: Text(
              todo.title.capitalize(),
              style: TextStyle(
                decoration: todo.isCompleted
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Column(
              children: [
                Text(
                  dateFormat.format(todo.createdAt),
                  overflow: TextOverflow.ellipsis,
                ),
                if (todo.description.isNotEmpty)
                  Text(
                    todo.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
              ],
            ),
            trailing: IconButton(
              onPressed: () => context.pushNamed('edit-todo', extra: todo),
              icon: const Icon(Icons.edit),
              tooltip: 'Edit ${todo.title}',
            ),
          ),
        );
      },
    );
  }
}
