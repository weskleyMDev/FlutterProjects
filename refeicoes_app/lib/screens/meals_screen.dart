import 'package:flutter/material.dart';
import 'package:refeicoes_app/components/meal_item.dart';
import 'package:refeicoes_app/models/category.dart';
import 'package:refeicoes_app/models/meal.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen(this.meals, {super.key});

  final List<Meal> meals;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)!.settings.arguments as Category;

    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: ListView.builder(
        itemCount: categoryMeals.length,
        itemBuilder: (context, index) {
          return MealItem(categoryMeals[index]);
        },
      ),
    );
  }
}
