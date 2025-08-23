import 'package:flutter/material.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Total: 10.00'),
              Text('Restante: 10.00')
            ],
          ),
        )
      ],
    );
  }
}
