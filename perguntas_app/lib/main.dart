import 'package:flutter/material.dart';

import './questoes.dart';
import './resultado.dart';

void main() {
  runApp(const PerguntasApp());
}

class _PerguntasAppState extends State<PerguntasApp> {
  var _perguntaSelecionada = 0;
  var _pontuacaoTotal = 0;
  final _perguntas = [
    {
      'texto': 'Qual é seu time favorito?',
      'respostas': [
        {'texto': 'Flamengo', 'pontos': 10},
        {'texto': 'Botafogo', 'pontos': 1},
        {'texto': 'Fluminense', 'pontos': 5},
      ]
    },
    {
      'texto': 'Qual é sua cor favorita?',
      'respostas': [
        {'texto': 'Verde', 'pontos': 5},
        {'texto': 'Azul', 'pontos': 10},
        {'texto': 'Branco', 'pontos': 1},
      ]
    },
    {
      'texto': 'Qual é seu animal favorito?',
      'respostas': [
        {'texto': 'Cachorro', 'pontos': 1},
        {'texto': 'Gato', 'pontos': 5},
        {'texto': 'Pássaro', 'pontos': 10},
      ]
    }
  ];

  void _responder(int pontuacao) {
    if (perguntasLoop) {
      setState(() {
        _perguntaSelecionada++;
        _pontuacaoTotal += pontuacao;
      });
    }
  }

  void _reiniciar() {
    setState(() {
      _perguntaSelecionada = 0;
      _pontuacaoTotal = 0;
    });
  }

  bool get perguntasLoop {
    return _perguntaSelecionada < _perguntas.length;
  }

  @override
  Widget build(BuildContext context) {
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
            : Resultado(
                pontuacao: _pontuacaoTotal,
                quandoReiniciar: () {
                  _reiniciar();
                },
              ),
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
