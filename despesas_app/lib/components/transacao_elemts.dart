import 'dart:math';

import 'package:despesas_app/components/transacao_form.dart';
import 'package:despesas_app/components/transacao_lista.dart';
import 'package:flutter/material.dart';

import '../model/transacao.dart';

class TransacaoElemts extends StatefulWidget {
  const TransacaoElemts({super.key});

  @override
  State<TransacaoElemts> createState() => _TransacaoElemtsState();
}

class _TransacaoElemtsState extends State<TransacaoElemts> {
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransacaoLista(_transacoes),
      TransacaoForm(_addTransacao),
    ]);
  }
}
