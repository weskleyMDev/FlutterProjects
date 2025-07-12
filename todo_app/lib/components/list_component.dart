import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../store/todo.store.dart';
import 'todo_component.dart';

class ListComponent extends StatelessWidget {
  const ListComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ToDoStore>(context);
    return Observer(
      builder: (_) => ListView.builder(
        shrinkWrap: true,
        itemCount: store.items.length,
        itemBuilder: (context, index) {
          final item = store.items[index];
          return Stack(
            children: [
              ListTile(
                tileColor: Theme.of(context).colorScheme.error,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                  ),
                ),
                title: Text(
                  ' '.toUpperCase(),
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                subtitle: Text(' '.toUpperCase()),
              ),
              Slidable(
                key: ValueKey(item.id),
                endActionPane: ActionPane(
                  extentRatio: 0.25,
                  motion: ScrollMotion(),
                  children: [
                    SlidableAction(
                      onPressed: (context) {},
                      backgroundColor: Colors.transparent,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.surface,
                      icon: Icons.delete_sharp,
                      label: 'Excluir',
                      padding: const EdgeInsets.all(0.0),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        bottomRight: Radius.circular(10.0),
                      ),
                    ),
                  ],
                ),
                child: Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: ToDoComponent(todo: item, index: index),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
