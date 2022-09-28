import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.valor, this.percet, {super.key});

  final String label;
  final double valor;
  final double percet;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          valor.toStringAsFixed(2),
        ),
        const SizedBox(
          height: 5,
        ),
        const SizedBox(
          height: 60,
          width: 10,
          child: null,
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          label,
        ),
      ],
    );
  }
}
