import 'package:flutter/material.dart';

class Resultado extends StatelessWidget {
  final int pontos;

  const Resultado(this.pontos, {super.key});

  String get fraseFinal {
    if (pontos <= 8) {
      return 'Parabens!';
    } else {
      return 'Tente Novamente';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        fraseFinal,
        style: const TextStyle(fontSize: 25.0),
      ),
    );
  }
}
