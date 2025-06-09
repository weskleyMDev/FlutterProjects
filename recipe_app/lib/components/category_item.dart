import 'package:flutter/material.dart';

import '../models/category.dart';
import '../utils/routes.dart';

class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.category});

  final Category category;

  void _navigateToMealScreen(BuildContext context) {
    Navigator.of(context).pushNamed(Routes.mealScreen, arguments: category);
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(15.0),
      splashColor: Theme.of(context).colorScheme.primary,
      onTap: () => _navigateToMealScreen(context),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          gradient: LinearGradient(
            colors: [category.color.withValues(alpha: 0.5), category.color],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
    );
  }
}
