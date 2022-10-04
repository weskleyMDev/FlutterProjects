import 'package:flutter/material.dart';
import 'package:refeicoes_app/components/meal_item.dart';
import 'package:refeicoes_app/utils/capitalize_words.dart';

import '../models/meal.dart';

class FavoriteScreen extends StatelessWidget with Capitalize {
  const FavoriteScreen(this.favoriteMeals, {super.key});

  final List<Meal> favoriteMeals;

  @override
  Widget build(BuildContext context) {
    String text = 'nenhuma refeição selecionada!';
    List<String> splited = text.split(' ');
    List<String> result = [];
    for (var element in splited) {
      result.add(element.capitalize());
    }
    text = result.join(' ');

    if (favoriteMeals.isEmpty) {
      return Center(
        child: Text(
          text,
          style: const TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
          ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: favoriteMeals.length,
        itemBuilder: (ctx, index) {
          return MealItem(favoriteMeals[index]);
        },
      );
    }
  }
}
