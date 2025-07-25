import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import '../stores/todo.store.dart';

class CustomInsertBar extends StatelessWidget {
  const CustomInsertBar({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final store = GetIt.instance<TodoStore>(instanceName: 'todoStore');

    void submitForm() {
      final isValid = formKey.currentState?.validate() ?? false;
      if (!isValid) return;
      store.setTitle(titleController.text);
      store.addTodo();
      titleController.clear();
      _showSnackBar(context, 'Task added successfully!');
    }

    return Form(
      key: formKey,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Container(
          margin: const EdgeInsets.only(top: 10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: const EdgeInsets.only(right: 10.0),
                  child: TextFormField(
                    key: const ValueKey('task'),
                    controller: titleController,
                    decoration: InputDecoration(
                      label: Text('New Task', overflow: TextOverflow.ellipsis),
                      hint: Text('Add new task'),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.list),
                    ),
                    maxLines: 1,
                    validator: (value) {
                      final title = value?.trim() ?? '';
                      if (title.isEmpty) return 'Campo obrigatório!';
                      return null;
                    },
                  ),
                ),
              ),
              ElevatedButton.icon(
                onPressed: submitForm,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusGeometry.circular(5.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                    vertical: 22.0,
                    horizontal: 10.0,
                  ),
                ),
                label: Text('ADD'),
                icon: Icon(Icons.save_outlined),
                iconAlignment: IconAlignment.end,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
        action: SnackBarAction(label: 'UNDO', onPressed: () {}),
      ),
    );
  }
}
