import 'package:flutter/material.dart';
import 'package:localdb/blocs/todo_view/todo_view_bloc.dart';
import 'package:localdb/widgets/build_todo_card.dart';

class BuildTodosView extends StatelessWidget {
  const BuildTodosView({super.key, required this.todoViewState});

  final TodoViewState todoViewState;

  @override
  Widget build(BuildContext context) {
    switch (todoViewState.status) {
      case TodoViewStatus.initial:
        return const Center(child: Text('Press the button to load todos.'));
      case TodoViewStatus.loading:
        return const Center(child: CircularProgressIndicator());
      case TodoViewStatus.success:
        final todos = todoViewState.sortedTodos;
        if (todos.isEmpty) {
          return const Center(child: Text('No todos found.'));
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return BuildTodoCard(todoId: todo.id);
          },
        );
      case TodoViewStatus.failure:
        return const Center(child: Text('Failed to load todos.'));
    }
  }
}
