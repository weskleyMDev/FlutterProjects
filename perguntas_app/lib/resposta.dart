import 'package:flutter/material.dart';

class Resposta extends StatelessWidget {
  final String texto;
  final void Function() quandoClicado;

  const Resposta(this.texto, this.quandoClicado, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(5),
      child: ElevatedButton(
        style:
            ElevatedButton.styleFrom(backgroundColor: Colors.deepPurpleAccent),
        onPressed: quandoClicado,
        child: Text(
          texto,
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
