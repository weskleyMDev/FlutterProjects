import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/transacao.dart';

class TransacaoLista extends StatelessWidget {
  final List<Transacao> transacoes;
  final void Function(String) removeTransacao;
  const TransacaoLista(this.transacoes, this.removeTransacao, {super.key});

  @override
  Widget build(BuildContext context) {
    return transacoes.isEmpty
        ? Column(
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
                height: 200,
                child: Image.asset(
                  'assets/images/snooze.png',
                  fit: BoxFit.cover,
                ),
              ),
            ],
          )
        : ListView.builder(
            itemCount: transacoes.length,
            itemBuilder: (ctxt, index) {
              final tr = transacoes[index];
              return Card(
                elevation: 5.0,
                margin: const EdgeInsets.symmetric(
                  vertical: 8.0,
                  horizontal: 5.0,
                ),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.lightGreen[700],
                    foregroundColor: Colors.white,
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: FittedBox(
                        child: Text(
                          'R\$${tr.valor.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tr.titulo,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  subtitle: Text(
                    DateFormat('d MMM y').format(tr.date),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    color: Colors.red[400],
                    onPressed: () => removeTransacao(tr.id),
                  ),
                ),
              );
            },
          );
  }
}
