import 'package:flutter/material.dart';

class MatrizstockScreen extends StatefulWidget {
  const MatrizstockScreen({super.key});

  @override
  State<MatrizstockScreen> createState() => _MatrizstockScreenState();
}

class _MatrizstockScreenState extends State<MatrizstockScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Estoque Matriz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Matriz de Estoque Screen',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}