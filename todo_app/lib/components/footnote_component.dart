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
        OutlinedButton(onPressed: store.removeAll, child: Text('REMOVER TUDO')),
      ],
    );
  }
}
