import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/utils/capitalize_text.dart';
import 'package:uuid/uuid.dart';

import '../models/todo.dart';
import '../store/todo.store.dart';

class InputComponent extends StatelessWidget {
  const InputComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final textController = TextEditingController();
    final store = Provider.of<ToDoStore>(context);
    void submit() {
      if (textController.text.isEmpty) return;
      final id = Uuid();
      final todo = ToDo(
        id: id.v4(),
        title: textController.text.trim().capitalize(),
        date: DateTime.now(),
      );
      store.addTodo(todo);
      textController.clear();
    }

    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: textController,
            decoration: InputDecoration(label: const Text('Insira uma tarefa')),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => submit(),
          ),
        ),
        const SizedBox(width: 10),
        OutlinedButton(
          onPressed: () {
            submit();
            FocusScope.of(context).unfocus();
          },
          child: const Icon(Icons.add_sharp),
        ),
      ],
    );
  }
}
