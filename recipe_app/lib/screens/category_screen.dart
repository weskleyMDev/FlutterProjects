import 'package:flutter/material.dart';
import 'package:recipe_app/models/meal.dart';

import '../components/meal_item.dart';
import '../models/category.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({
    super.key,
    required this.meals,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final List<Meal> meals;
  final void Function(Meal) onFavoriteToggle;
  final bool Function(Meal) isFavorite;

  @override
  Widget build(BuildContext context) {
    final category = ModalRoute.of(context)?.settings.arguments as Category;

    final categoryMeal = meals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
        centerTitle: true,
        backgroundColor: category.color,
      ),
      body: ListView.builder(
        itemCount: categoryMeal.length,
        itemBuilder: (context, index) {
          final meal = categoryMeal[index];
          return MealItem(
            meal: meal,
            onFavoriteToggle: onFavoriteToggle,
            isFavorite: isFavorite,
          );
        },
      ),
    );
  }
}
