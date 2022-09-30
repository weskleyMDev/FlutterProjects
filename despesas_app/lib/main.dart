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
  bool _mostrarChart = false;
  final List<Transacao> _transacoes = [];

  List<Transacao> get _recenteTransacao {
    return _transacoes.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(
        const Duration(days: 7),
      ));
    }).toList();
  }

  _addTransacao(String titulo, double valor, DateTime date) {
    final newTransacao = Transacao(
      id: Random().nextDouble().toString(),
      titulo: titulo,
      valor: valor,
      date: date,
    );

    setState(() {
      _transacoes.add(newTransacao);
    });

    Navigator.of(context).pop();
  }

  _deleteTransacao(String id) {
    setState(() {
      _transacoes.removeWhere((tr) => tr.id == id);
    });
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
    final mediaQuery = MediaQuery.of(context);
    bool isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text(
        'Despesas App Flutter',
        style: TextStyle(
          fontSize: 20 * mediaQuery.textScaleFactor,
        ),
      ),
      actions: <Widget>[
        if (isLandscape)
          IconButton(
            onPressed: () {
              setState(() {
                _mostrarChart = !_mostrarChart;
              });
            },
            icon: Icon(_mostrarChart ? Icons.list : Icons.show_chart),
          ),
        IconButton(
          onPressed: () {
            _abrirTransacaoFormModal(context);
          },
          icon: const Icon(Icons.add),
        )
      ],
      backgroundColor: Theme.of(context).colorScheme.primary,
    );

    final alturaResp = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    return MaterialApp(
      home: Scaffold(
        appBar: appBar,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              if (_mostrarChart || !isLandscape)
                SizedBox(
                  height: alturaResp * (isLandscape ? 0.7 : 0.3),
                  child: Chart(recenteTransacao: _recenteTransacao),
                ),
              if (!_mostrarChart || !isLandscape)
                SizedBox(
                  height: alturaResp * 0.68,
                  child: TransacaoLista(_transacoes, _deleteTransacao),
                ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _abrirTransacaoFormModal(context);
          },
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}
