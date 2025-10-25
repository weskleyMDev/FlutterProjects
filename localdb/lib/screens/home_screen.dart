import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/models/todo_model.dart';
import 'package:localdb/widgets/build_todos_view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final todoViewBloc = BlocProvider.of<TodoViewBloc>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        actions: [
          BlocSelector<TodoViewBloc, TodoViewState, List<TodoModel>>(
            selector: (state) => state.todos,
            builder: (context, todos) {
              return IconButton(
                icon: Icon(
                  todos.isNotEmpty
                      ? Icons.sync_sharp
                      : Icons.cloud_download_sharp,
                ),
                onPressed: () => todoViewBloc.add(const LoadTodoViewEvent()),
                tooltip: todos.isNotEmpty ? 'Reload Todos' : 'Load Todos',
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 8.0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Expanded(
              child: BlocBuilder<TodoViewBloc, TodoViewState>(
                buildWhen: (previous, current) =>
                    previous.status != current.status ||
                    previous.todos != current.todos,
                builder: (_, todoViewState) {
                  return BuildTodosView(todoViewState: todoViewState);
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.pushNamed('edit-todo'),
        child: Icon(Icons.add),
      ),
    );
  }
}
