import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transacao.dart';

class ItemTransacao extends StatelessWidget {
  const ItemTransacao({
    Key? key,
    required this.tr,
    required this.removeTransacao,
  }) : super(key: key);

  final void Function(String) removeTransacao;
  final Transacao tr;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5.0,
      margin: const EdgeInsets.symmetric(
        vertical: 8.0,
        horizontal: 5.0,
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.lightGreen[700],
          foregroundColor: Colors.white,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                'R\$${tr.valor.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          tr.titulo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => removeTransacao(tr.id),
                icon: const Icon(Icons.delete),
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.red),
                ),
                label: const Text('Excluir'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => removeTransacao(tr.id),
              ),
      ),
    );
  }
}