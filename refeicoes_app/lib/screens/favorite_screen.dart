import 'package:flutter/material.dart';

import '../models/meal.dart';

extension MyExtension on String {
      String capitalize() {
        return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
      }
    }

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen(this.favoriteMeals, {super.key});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    const String text = 'nenhuma refeição selecionada!';
    final splited = text.split('');
    return Center(
      child: Text(
        text.capitalize(),
      ),
    );
  }
}
