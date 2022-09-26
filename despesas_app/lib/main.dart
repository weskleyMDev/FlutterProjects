// ignore_for_file: prefer_const_constructors

import 'package:despesas_app/components/transacao_elemts.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(DespesasApp());
}

class DespesasApp extends StatelessWidget {
  const DespesasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Despesas App Flutter'),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ignore: avoid_unnecessary_containers
              Container(
                child: Card(
                  color: Colors.blue,
                  elevation: 5,
                  child: Text('Gráfico'),
                ),
              ),
              TransacaoElemts(),
            ],
          ),
        ),
      ),
    );
  }
}
