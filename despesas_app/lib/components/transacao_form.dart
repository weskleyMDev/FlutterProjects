// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class TransacaoForm extends StatelessWidget {
  const TransacaoForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // ignore: prefer_const_literals_to_create_immutables
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Título',
              ),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: 'Valor (R\$)',
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.purple,
                  ),
                  child: Text('Nova transação'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
