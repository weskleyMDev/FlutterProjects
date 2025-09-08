import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:todo/blocs/todo_bloc.dart';
import 'package:todo/screens/loading_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final TodoBloc _todoBloc;
  late final TextEditingController _textEditingController;
  @override
  void initState() {
    super.initState();
    _todoBloc = BlocProvider.of<TodoBloc>(context);
    _textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  void _submitText() {
    final text = _textEditingController.text.trim();
    if (text.isEmpty) return;
    _todoBloc.add(AddTodo(text));
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(centerTitle: true, title: const Text('Todo App')),
      body: Stack(
        children: [
          BlocBuilder<TodoBloc, TodoState>(
            builder: (context, todoState) {
              final todos = todoState.todos;
              return Stack(
                children: [
                  ListView.builder(
                    itemCount: todos.length,
                    itemBuilder: (context, index) {
                      final todo = todos[index];
                      final date = DateFormat.yMEd().add_Hm().format(
                        todo.createdAt,
                      );
                      return ListTile(
                        title: Text(todo.text),
                        subtitle: Text(date),
                        trailing: IconButton(
                          onPressed: () => _todoBloc.add(DeleteTodo(todo.id)),
                          icon: const Icon(Icons.delete_rounded),
                        ),
                      );
                    },
                  ),
                  if (todoState.status == TodoStatus.loading)
                    const LoadingScreen(),
                ],
              );
            },
          ),
          Positioned(
            bottom: 0.0,
            right: 0.0,
            left: 0.0,
            child: Card(
              margin: const EdgeInsets.all(12.0),
              elevation: 2.0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: 'Add Todo',
                        ),
                        onSubmitted: (_) => _submitText(),
                      ),
                    ),
                    IconButton(
                      onPressed: _submitText,
                      icon: Icon(Icons.add_rounded),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
