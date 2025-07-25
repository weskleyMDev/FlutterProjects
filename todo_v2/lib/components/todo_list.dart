import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';

import '../stores/todo.store.dart';
import 'todo_list_item.dart';

class CustomTodoList extends StatefulWidget {
  const CustomTodoList({super.key});

  @override
  State<CustomTodoList> createState() => _CustomTodoListState();
}

class _CustomTodoListState extends State<CustomTodoList> {
  final store = GetIt.instance<TodoStore>(instanceName: 'todoStore');

  @override
  void initState() {
    super.initState();
    store.init();
  }

  @override
  void dispose() {
    store.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final todoList = store.todoStream.value ?? [];
        return todoList.isEmpty
            ? const Center(child: Text('None task found!'))
            : ListView.builder(
                itemCount: todoList.length,
                itemBuilder: (context, index) {
                  return TodoListItem(
                    store: store,
                    todo: todoList,
                    index: index,
                  );
                },
              );
      },
    );
  }
}
