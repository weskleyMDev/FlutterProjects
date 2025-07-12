import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../store/todo.store.dart';

class FootnoteComponent extends StatelessWidget {
  const FootnoteComponent({super.key});

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<ToDoStore>(context);

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Observer(
            builder: (_) => Text.rich(
              TextSpan(
                text: 'Você possui '.toUpperCase(),
                children: [
                  TextSpan(
                    text: store.items.length.toString(),
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18.0,
                    ),
                  ),
                  TextSpan(
                    text: store.items.length == 1
                        ? ' tarefa.'.toUpperCase()
                        : ' tarefas.'.toUpperCase(),
                  ),
                ],
              ),
            ),
          ),
        ),
        OutlinedButton(
          onPressed: () async {
            try {
              if (store.items.isEmpty) return;
              final confirm = await _confirmDialog(
                context,
                'Excluir Tarefas?',
                'Deseja excluir todas as tarefas?',
              );
              if (confirm != null && confirm) {
                store.removeAll();
              }
            } catch (e) {
              rethrow;
            }
          },
          child: Text('REMOVER TUDO'),
        ),
      ],
    );
  }

  Future<bool?> _confirmDialog(
    BuildContext context,
    String title,
    String message,
  ) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(false),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true),
          child: const Text('Ok'),
        ),
      ],
    ),
  );
}
