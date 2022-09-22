import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  const Resultado(
      {super.key, required this.pontuacao, required this.quandoReiniciar});

  final int pontuacao;
  final void Function() quandoReiniciar;

  String get fraseResultado {
    if (pontuacao < 9) {
      return 'Tente Novamente';
    } else {
      return 'Parabéns';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Center(
          child: Text(
            fraseResultado,
            style: const TextStyle(fontSize: 25.0),
          ),
        ),
        TextButton(
          onPressed: quandoReiniciar,
          child: const Text(
            'Reiniciar?',
            style: TextStyle(
              fontSize: 20,
              color: Colors.red,
            ),
          ),
        )
      ],
    );
  }
}
