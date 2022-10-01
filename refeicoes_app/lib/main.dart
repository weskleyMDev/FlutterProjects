import 'package:flutter/material.dart';
import 'package:refeicoes_app/screens/categories_screen.dart';
import 'package:refeicoes_app/screens/meals_screen.dart';
import 'package:refeicoes_app/utils/app_routes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Refeições App Flutter',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.brown)
            .copyWith(secondary: Colors.amber),
        fontFamily: 'Raleway',
        canvasColor: const Color.fromRGBO(251, 251, 253, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
          titleMedium: const TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed',
          ),
        ),
      ),
      home: const CategoriesScreen(),
      routes: {
        AppRoutes.MEALS:(ctx) => const MealsScreen(),
      },
    );
  }
}
