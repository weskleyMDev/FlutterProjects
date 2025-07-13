import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/todo.dart';

class ToDoComponent extends StatelessWidget {
  const ToDoComponent({super.key, required this.todo, required this.index});

  final ToDo todo;
  final int index;

  @override
  Widget build(BuildContext context) {
    final date = DateFormat('EEEE, dd/MM/y', 'pt_BR').format(todo.date);
    final time = DateFormat('HH:mm', 'pt_BR').format(todo.date);
    return ListTile(
      tileColor: Theme.of(context).colorScheme.surfaceDim,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Theme.of(context).colorScheme.outline),
      ),
      leading: CircleAvatar(child: Text('${index + 1}')),
      title: Text(
        todo.title,
        style: Theme.of(context).textTheme.titleLarge,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        date
            .split(' ')
            .map((e) => e[0].toUpperCase() + e.substring(1))
            .join(' '),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(top: 28.0),
        child: Text(time),
      ),
    );
  }
}
