import 'dart:math';

import 'package:despesas_app/components/chart.dart';
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
          primary: Colors.green[700],
          secondary: Colors.green[500],
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
  final List<Transacao> _transacoes = [
    Transacao(
      id: 't0',
      titulo: 'Internet',
      valor: 49.90,
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  List<Transacao> get _recenteTransacao {
    return _transacoes.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

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
            children: <Widget>[
              Chart(recenteTransacao: _recenteTransacao),
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
