import 'package:flutter/material.dart';
import 'package:refeicoes_app/models/category.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.category, {super.key});

  final Category category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('Receitas por Categoria ${category.id}'),
      ),
    );
  }
}
