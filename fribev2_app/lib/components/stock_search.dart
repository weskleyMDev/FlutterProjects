import 'package:flutter/material.dart';

class StockSearch extends StatelessWidget {
  const StockSearch({super.key, required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        controller: controller,
        decoration: const InputDecoration(
          labelText: 'Buscar',
          border: OutlineInputBorder(),
          suffixIcon: Icon(Icons.search_outlined),
        ),
      ),
    );
  }
}
