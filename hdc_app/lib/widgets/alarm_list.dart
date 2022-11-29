import 'package:flutter/material.dart';

import '../models/lembrete.dart';
import 'alarm_item.dart';

class AlarmeLista extends StatefulWidget {
  const AlarmeLista(
    this.lembretes,
    this.removeLembrete,
    this.abrirModal, {
    super.key,
  });

  final void Function(int) removeLembrete;
  final void Function(BuildContext) abrirModal;
  final List<Lembrete> lembretes;

  @override
  State<AlarmeLista> createState() => _AlarmeListaState();
}

class _AlarmeListaState extends State<AlarmeLista> {
  @override
  Widget build(BuildContext context) {
    return widget.lembretes.isEmpty
        ? LayoutBuilder(
            builder: (ctx, constraints) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  OutlinedButton(
                    onPressed: () => widget.abrirModal(context),
                    style: OutlinedButton.styleFrom(
                        shape: const CircleBorder(),
                        padding: const EdgeInsets.all(25),
                        backgroundColor:
                            const Color.fromRGBO(209, 244, 250, 1)),
                    child: const Icon(
                      Icons.notifications_active_rounded,
                      size: 40,
                      color: Color.fromRGBO(5, 40, 46, 1),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Não Há Nada Aqui',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 12.0,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 18.0),
                    child: Text(
                      'Adicione um lembrete e te avisaremos quando for a hora de tomar a dose do seu remédio',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            itemCount: widget.lembretes.length,
            itemBuilder: (context, index) {
              final lb = widget.lembretes[index];
              return ItemAlarme(
                key: GlobalObjectKey(lb),
                lb: lb,
                removeLembrete: widget.removeLembrete,
              );
            },
          );
  }
}
