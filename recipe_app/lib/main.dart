import 'package:flutter/material.dart';
import 'package:recipe_app/data/dummy_data.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/models/settings.dart';
import 'package:recipe_app/screens/setting_screen.dart';
import 'package:recipe_app/screens/tab_screen.dart';

import 'screens/category_screen.dart';
import 'themes/recipe_theme.dart';
import 'utils/routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  List<Meal> _availableMeals = dummyMeals;
  Settings _settings = Settings();
  final List<Meal> _favoriteMeals = [];

  void _filterMeals(Settings settings) {
    setState(() {
      _settings = settings;
      _availableMeals = dummyMeals.where((meal) {
        final isGlutenFree = settings.isGlutenFree ? meal.isGlutenFree : true;
        final isLactoseFree = settings.isLactoseFree
            ? meal.isLactoseFree
            : true;
        final isVegan = settings.isVegan ? meal.isVegan : true;
        final isVegetarian = settings.isVegetarian ? meal.isVegetarian : true;

        return isGlutenFree && isLactoseFree && isVegan && isVegetarian;
      }).toList();
    });
  }

  void _toggleFavorite(Meal meal) {
    setState(() {
      _favoriteMeals.contains(meal)
          ? _favoriteMeals.remove(meal)
          : _favoriteMeals.add(meal);
    });
  }

  bool _isFavorite(Meal meal) {
    return _favoriteMeals.contains(meal);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: recipeAppTheme,
      home: TabScreen(
        favoriteMeals: _favoriteMeals,
        onFavoriteToggle: _toggleFavorite,
        isFavorite: _isFavorite,
      ),
      routes: {
        Routes.mealScreen: (_) => CategoryScreen(
          meals: _availableMeals,
          onFavoriteToggle: _toggleFavorite,
          isFavorite: _isFavorite,
        ),
        Routes.settingScreen: (_) =>
            SettingScreen(onSettingsChanged: _filterMeals, settings: _settings),
      },
    );
  }
}
