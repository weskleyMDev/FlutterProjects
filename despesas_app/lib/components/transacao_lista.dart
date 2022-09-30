import 'package:flutter/material.dart';

import '../model/transacao.dart';
import 'transacao_item.dart';

class TransacaoLista extends StatelessWidget {
  const TransacaoLista(this.transacoes, this.removeTransacao, {super.key});

  final void Function(String) removeTransacao;
  final List<Transacao> transacoes;

  @override
  Widget build(BuildContext context) {
    return transacoes.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Lista Vazia!',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/images/snooze.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (ctxt, index) {
              final tr = transacoes[index];
              return ItemTransacao(
                tr: tr,
                removeTransacao: removeTransacao,
              );
            },
          );
  }
}
