import 'package:flutter/material.dart';

void main() {
  runApp(const PerguntasApp());
}

class PerguntasApp extends StatelessWidget {
  const PerguntasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Perguntas App'),
        ),
        body: const Center(
          child: Text('Ola Mundo'),
        ),
      ),
    );
  }
}
