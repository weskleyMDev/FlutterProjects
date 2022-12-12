import 'package:flutter/material.dart';

import '../models/cartas_map.dart';

class ItemCarta extends StatelessWidget {
  const ItemCarta({super.key, required this.carta});

  final CartasMap carta;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: carta.color,
      ),
      child: Center(
        child: Text(
          carta.id,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: carta.font,
          ),
        ),
      ),
    );
  }
}
