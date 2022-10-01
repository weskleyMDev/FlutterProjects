import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transacao.dart';

class ItemTransacao extends StatefulWidget {
  const ItemTransacao({
    Key? key,
    required this.tr,
    required this.removeTransacao,
  }) : super(key: key);

  final void Function(String) removeTransacao;
  final Transacao tr;

  @override
  State<ItemTransacao> createState() => _ItemTransacaoState();
}

class _ItemTransacaoState extends State<ItemTransacao> {
  static const colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.amber,
    Colors.purple,
  ];

  late Color _backgroundColor;

  @override
  void initState() {
    super.initState();
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
  }

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
          backgroundColor: _backgroundColor,
          foregroundColor: Colors.white,
          radius: 30,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                'R\$${widget.tr.valor.toStringAsFixed(2)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
        title: Text(
          widget.tr.titulo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat('d MMM y').format(widget.tr.date),
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.removeTransacao(widget.tr.id),
                icon: const Icon(Icons.delete),
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.red),
                ),
                label: const Text('Excluir'),
              )
            : IconButton(
                icon: const Icon(Icons.delete),
                color: Colors.red,
                onPressed: () => widget.removeTransacao(widget.tr.id),
              ),
      ),
    );
  }
}
