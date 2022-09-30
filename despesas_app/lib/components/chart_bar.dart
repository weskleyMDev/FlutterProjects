import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  const ChartBar(this.label, this.valor, this.percet, {super.key});

  final String label;
  final double percet;
  final double valor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: <Widget>[
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                valor.toStringAsFixed(2),
              ),
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.10,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: const Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percet,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.lightGreen[900],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: constraints.maxHeight * 0.10,
          ),
          SizedBox(
            height: constraints.maxHeight * 0.10,
            child: FittedBox(
              child: Text(
                label,
              ),
            ),
          ),
        ],
      );
    });
  }
}
