import 'package:flutter/material.dart';

import './resultado.dart';
import './questoes.dart';

void main() {
  runApp(const PerguntasApp());
}

class _PerguntasAppState extends State<PerguntasApp> {
  var _perguntaSelecionada = 0;
  var _pontosTotal = 0;
  final _perguntas = [
    {
      'texto': 'Qual é seu time favorito?',
      'respostas': [
        {'texto': 'Flamengo', 'nota': 10},
        {'texto': 'Botafogo', 'nota': 1},
        {'texto': 'Fluminense', 'nota': 5},
      ]
    },
    {
      'texto': 'Qual é sua cor favorita?',
      'respostas': [
        {'texto': 'Verde', 'nota': 5},
        {'texto': 'Azul', 'nota': 10},
        {'texto': 'Branco', 'nota': 1},
      ]
    },
    {
      'texto': 'Qual é seu animal favorito?',
      'respostas': [
        {'texto': 'Cachorro', 'nota': 1},
        {'texto': 'Gato', 'nota': 5},
        {'texto': 'Pássaro', 'nota': 10},
      ]
    }
  ];

  void _responder(int pontos) {
    if (perguntasLoop) {
      setState(() {
        _perguntaSelecionada++;
        _pontosTotal += pontos;
      });
    }
  }

  bool get perguntasLoop {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
    // List<Widget> respostas = [];
    // for (String textoResp
    //     in _perguntas[_perguntaSelecionada].cast()['respostas']) {
    //   respostas.add(Resposta(textoResp, _responder));
    // }

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.deepPurple,
          title: const Text('Perguntas App Flutter'),
        ),
        body: perguntasLoop
            ? Questoes(
                perguntas: _perguntas,
                perguntaSelecionada: _perguntaSelecionada,
                responder: _responder,
              )
            : Resultado(_pontosTotal),
      ),
    );
  }
}

class PerguntasApp extends StatefulWidget {
  const PerguntasApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return _PerguntasAppState();
  }
}
