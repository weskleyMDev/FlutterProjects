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
              return SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Lista Vazia!',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      SizedBox(height: constraints.maxHeight * 0.05),
                      Image.asset(
                        'assets/images/snooze.png',
                        fit: BoxFit.contain,
                        height: constraints.maxHeight * 0.6,
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (ctxt, index) {
              final tr = transacoes[index];
              return ItemTransacao(
                key: ValueKey(tr.id),
                tr: tr,
                removeTransacao: removeTransacao,
              );
            },
          );
  }
}
