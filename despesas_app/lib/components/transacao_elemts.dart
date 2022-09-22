// ignore_for_file: prefer_const_constructors

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

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      TransacaoLista(_transacoes),
      TransacaoForm(),
    ]);
  }
}
