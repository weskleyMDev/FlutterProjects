import 'package:flutter/material.dart';

import 'questao.dart';
import 'resposta.dart';

class Questoes extends StatelessWidget {
  final List<Map<String, Object>> perguntas;
  final int perguntaSelecionada;
  final void Function(int) responder;

  const Questoes(
      {super.key,
      required this.perguntas,
      required this.perguntaSelecionada,
      required this.responder});

  bool get perguntasLoop {
    return perguntaSelecionada < perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    List<Map<String, Object>> respostas =
        perguntasLoop ? perguntas[perguntaSelecionada].cast()['respostas'] : [];

    return Column(
      children: [
        Questao(perguntas[perguntaSelecionada]['texto'].toString()),
        ...respostas.map((res) {
          return Resposta(
            res['texto'].toString(),
            () => responder(int.parse(res['pontos'].toString())),
          );
        }).toList(),
      ],
    );
  }
}
