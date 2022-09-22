import 'package:flutter/material.dart';

void main() {
  runApp(const DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas App Flutter'),
        ),
        body: Column(
          children: const [
            SizedBox(
              width: double.infinity,
              child: Card(
                color: Colors.blue,
                elevation: 5,
                child: Text('Gráfico'),
              ),
            ),
            Card(
              child: Text('Lista de Transações'),
            ),
          ],
        ),
      ),
    );
  }
}
