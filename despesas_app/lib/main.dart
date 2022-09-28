import 'dart:math';

import 'package:despesas_app/components/transacao_form.dart';
import 'package:despesas_app/components/transacao_lista.dart';
import 'package:flutter/material.dart';

import '../model/transacao.dart';

void main() {
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData tema = ThemeData();

    return MaterialApp(
      home: const HomePage(),
      theme: tema.copyWith(
        colorScheme: tema.colorScheme.copyWith(
          primary: Colors.purple[700],
          secondary: Colors.purple[500],
        ),
        textTheme: tema.textTheme.copyWith(
          headline6: const TextStyle(
            fontFamily: 'Quicksand',
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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

  _addTransacao(String titulo, double valor) {
    final newTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      date: DateTime.now(),
    );

    setState(() {
      _transacoes.add(newTransacao);
    });

    Navigator.of(context).pop();
  }

  _abrirTransacaoFormModal(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return TransacaoForm(_addTransacao);
        });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'Despesas App Flutter',
            style: Theme.of(context).appBarTheme.titleTextStyle,
          ),
          actions: [
            IconButton(
              onPressed: () {
                _abrirTransacaoFormModal(context);
              },
              icon: const Icon(Icons.add),
            )
          ],
          backgroundColor: Theme.of(context).colorScheme.primary,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Card(
                  color: Theme.of(context).colorScheme.primary,
                  elevation: 5,
                  child: Text(
                    'Gráfico',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
              ),
              TransacaoLista(_transacoes),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _abrirTransacaoFormModal(context);
          },
          backgroundColor: Theme.of(context).colorScheme.secondary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
