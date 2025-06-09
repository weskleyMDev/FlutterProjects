import 'package:flutter/material.dart';
import 'package:recipe_app/components/meal_item.dart';
import 'package:recipe_app/models/meal.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({
    super.key,
    required this.favoriteMeals,
    required this.onFavoriteToggle, required this.isFavorite,
  });

  final List<Meal> favoriteMeals;
  final void Function(Meal) onFavoriteToggle;
  final bool Function(Meal) isFavorite;

  @override
  State<FavoriteScreen> createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  @override
  Widget build(BuildContext context) {
    return widget.favoriteMeals.isEmpty
        ? Center(child: Text("Nenhuma receita favorita!"))
        : ListView.builder(
            itemCount: widget.favoriteMeals.length,
            itemBuilder: (context, index) {
              final meal = MealItem(
                meal: widget.favoriteMeals[index],
                onFavoriteToggle: widget.onFavoriteToggle,
                isFavorite: widget.isFavorite,
              );
              return meal;
            },
          );
  }
}
