import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../store/todo.store.dart';

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
          final date = DateFormat('EEEE, dd/MM/y', 'pt_BR').format(item.date);
          final time = DateFormat('HH:mm', 'pt_BR').format(item.date);
          return ListTile(
            leading: CircleAvatar(child: Text('${index + 1}')),
            title: Text(
              item.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(date),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 22.0),
              child: Text(time),
            ),
          );
        },
      ),
    );
  }
}
