import 'package:flutter/material.dart';

import '../stores/todo.store.dart';

class TodoListItem extends StatefulWidget {
  const TodoListItem({
    super.key,
    required this.store,
    required this.todo,
    required this.index,
  });

  final TodoStore store;
  final List<Map<String, dynamic>> todo;
  final int index;

  @override
  State<TodoListItem> createState() => _TodoListItemState();
}

class _TodoListItemState extends State<TodoListItem> {
  void _showSnackBar(
    BuildContext context,
    String message, {
    Map<String, dynamic>? todo,
    int? pos,
  }) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message, style: TextStyle(fontWeight: FontWeight.bold)),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            if (todo == null || pos == null) return;
            widget.store.rendo(pos, todo);
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final todoItem = widget.todo[widget.index];
    return Dismissible(
      key: ValueKey(todoItem['title']),
      background: Container(
        color: Theme.of(context).colorScheme.onError,
        child: Align(
          alignment: Alignment(-0.9, 0.0),
          child: Icon(Icons.delete_rounded, color: Colors.white),
        ),
      ),
      direction: DismissDirection.startToEnd,
      child: CheckboxListTile(
        secondary: CircleAvatar(
          backgroundColor: todoItem['done']
              ? Theme.of(context).colorScheme.onPrimary
              : Theme.of(context).colorScheme.onError,
          child: FittedBox(
            fit: BoxFit.cover,
            child: Icon(
              todoItem['done'] ? Icons.check : Icons.close,
            ),
          ),
        ),
        title: Text(
          todoItem['title'],
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        subtitle: Text(
          todoItem['done'] ? 'Completed' : 'Pending',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
        ),
        value: todoItem['done'],
        onChanged: (value) {
          widget.store.setDoneTodo(widget.index, value);
        },
      ),
      onDismissed: (direction) {
        final lastRemoved = Map<String, dynamic>.from(
          todoItem,
        );
        final lastPos = widget.index;
        widget.store.removeTodo(widget.index);
        _showSnackBar(
          context,
          'Task removed successfully!',
          todo: lastRemoved,
          pos: lastPos,
        );
      },
    );
  }
}
