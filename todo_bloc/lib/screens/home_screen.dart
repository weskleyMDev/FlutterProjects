import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:todo/blocs/todo_bloc.dart';
import 'package:todo/blocs/todo_event.dart';
import 'package:todo/blocs/todo_state.dart';
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
    _todoBloc = context.read<TodoBloc>()..add(FetchTodos());
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
    _todoBloc.add(AddTodo(text: text));
    _textEditingController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(centerTitle: true, title: const Text('Todo App')),
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 80),
              child: BlocBuilder<TodoBloc, TodoState>(
                builder: (_, state) {
                  switch (state) {
                    case TodoInitial():
                    case TodoLoading():
                      return LoadingScreen();
                    case TodoLoaded():
                      final todos = state.todos;
                      if (todos.isEmpty) {
                        return const Center(child: Text('No todos found'));
                      } else {
                        return ListView.builder(
                          itemCount: todos.length,
                          itemBuilder: (_, index) {
                            final todo = todos[index];
                            return ListTile(
                              title: Text(todo.text),
                              trailing: IconButton(
                                onPressed: () =>
                                    _todoBloc.add(DeleteTodo(id: todo.id)),
                                icon: Icon(FontAwesome5.trash_alt),
                                iconSize: 18.0,
                                color: Colors.red,
                                padding: EdgeInsets.zero,
                                tooltip: 'Remove Todo',
                              ),
                            );
                          },
                        );
                      }
                    case TodoError():
                      return Center(
                        child: Text('Error: ${state.error.toString()}'),
                      );
                  }
                },
              ),
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.done,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12)),
                          ),
                          labelText: 'Add Todo',
                        ),
                        onSubmitted: (_) => _submitText(),
                      ),
                    ),
                    IconButton(
                      onPressed: _submitText,
                      icon: const Icon(FontAwesome5.plus),
                      iconSize: 18.0,
                      color: Colors.deepPurple,
                      padding: EdgeInsets.zero,
                      tooltip: 'Add Todo',
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
