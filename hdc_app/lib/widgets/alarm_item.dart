import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hdc_app/models/lembrete.dart';

class ItemAlarme extends StatefulWidget {
  const ItemAlarme({
    required this.lb,
    required this.removeLembrete,
    super.key,
  });

  final void Function(int) removeLembrete;
  final Lembrete lb;

  @override
  State<ItemAlarme> createState() => _ItemAlarmeState();
}

class _ItemAlarmeState extends State<ItemAlarme> {
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
    int i = Random().nextInt(5);
    _backgroundColor = colors[i];
    super.initState();
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
          radius: 30.0,
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: FittedBox(
              child: Text(
                widget.lb.horas,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          widget.lb.titulo,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          widget.lb.desc,
        ),
        trailing: MediaQuery.of(context).size.width > 480
            ? TextButton.icon(
                onPressed: () => widget.removeLembrete(widget.lb.id),
                icon: const Icon(Icons.delete),
                style: const ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(Colors.red),
                ),
                label: const Text('Excluir'),
              )
            : IconButton(
                onPressed: () => widget.removeLembrete(widget.lb.id),
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
      ),
    );
  }
}
