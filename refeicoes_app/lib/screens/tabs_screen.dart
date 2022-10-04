import 'package:flutter/material.dart';
import 'package:refeicoes_app/components/main_drawer.dart';
import 'package:refeicoes_app/models/meal.dart';
import 'package:refeicoes_app/screens/categories_screen.dart';
import 'package:refeicoes_app/screens/favorite_screen.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen(this.favoriteMeals, {super.key});

  final List<Meal> favoriteMeals;

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedScreenIndex = 0;
  late List<Map<String, Object>> _screens;

  @override
  void initState() {
    _screens = [
      {
        'title': 'Receitas por Categorias',
        'screen': const CategoriesScreen(),
      },
      {
        'title': 'Minhas Receitas Favoritas',
        'screen': FavoriteScreen(widget.favoriteMeals),
      },
    ];
    super.initState();
  }

  _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_screens[_selectedScreenIndex]['title'] as String),
      ),
      drawer: const MainDrawer(),
      body: _screens[_selectedScreenIndex]['screen'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectScreen,
        backgroundColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.secondary,
        unselectedFontSize: 16,
        selectedItemColor: Colors.white,
        selectedFontSize: 16,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w400),
        currentIndex: _selectedScreenIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Receitas',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star_rate),
            label: 'Favoritos',
          )
        ],
      ),
    );
  }
}
