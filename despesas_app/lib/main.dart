// ignore_for_file: prefer_const_constructors

import 'package:despesas_app/components/transacao_form.dart';
import 'package:despesas_app/components/transacao_lista.dart';
import 'package:despesas_app/model/transacao.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final _transacoes = [
    Transacao(
      id: 't1',
      titulo: 'Lanche',
      valor: 28.90,
      date: DateTime.now(),
    ),
    Transacao(
      id: 't2',
      titulo: 'Conta de Luz',
      valor: 99.90,
      date: DateTime.now(),
    )
  ];

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas App Flutter'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ignore: avoid_unnecessary_containers
            Container(
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            TransacaoLista(_transacoes),
            TransacaoForm(),
          ],
        ),
      ),
    );
  }
}
