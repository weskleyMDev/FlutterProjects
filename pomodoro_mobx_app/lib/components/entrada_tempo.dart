import 'package:flutter/material.dart';

class EntradaTempo extends StatelessWidget {
  const EntradaTempo({
    super.key,
    required this.valor,
    required this.titulo,
    this.increment,
    this.decrement,
  });

  final int valor;
  final String titulo;
  final void Function()? increment;
  final void Function()? decrement;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(titulo.toUpperCase(), style: TextStyle(fontSize: 22.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: decrement,
              icon: Icon(Icons.arrow_downward_sharp),
              color: Colors.white,
              style: IconButton.styleFrom(
                backgroundColor: Colors.red,
                disabledBackgroundColor: Colors.grey,
              ),
            ),
            Text('$valor min', style: TextStyle(fontSize: 18.0)),
            IconButton(
              onPressed: increment,
              icon: Icon(Icons.arrow_upward_sharp),
              color: Colors.white,
              style: IconButton.styleFrom(
                backgroundColor: Colors.green,
                disabledBackgroundColor: Colors.grey,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
