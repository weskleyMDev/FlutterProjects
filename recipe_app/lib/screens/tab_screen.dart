import 'package:flutter/material.dart';
import 'package:recipe_app/components/home_drawer.dart';
import 'package:recipe_app/models/meal.dart';
import 'package:recipe_app/screens/favorite_screen.dart';
import 'package:recipe_app/screens/home_screen.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({
    super.key,
    required this.favoriteMeals,
    required this.onFavoriteToggle,
    required this.isFavorite,
  });

  final List<Meal> favoriteMeals;
  final void Function(Meal) onFavoriteToggle;
  final bool Function(Meal) isFavorite;

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int _selectedIndex = 0;
  late final List<Map<String, Object>> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      {"title": "Receitas", "screen": HomeScreen()},
      {
        "title": "Favoritos",
        "screen": FavoriteScreen(
          favoriteMeals: widget.favoriteMeals,
          onFavoriteToggle: widget.onFavoriteToggle,
          isFavorite: widget.isFavorite,
        ),
      },
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(_pages[_selectedIndex]["title"] as String),
          centerTitle: true,
          titleTextStyle: Theme.of(context).textTheme.headlineMedium,
        ),
        drawer: const HomeDrawer(),
        body: _pages[_selectedIndex]["screen"] as Widget,
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primary,
          selectedItemColor: Theme.of(context).colorScheme.onPrimary,
          currentIndex: _selectedIndex,
          items: [
            const BottomNavigationBarItem(
              icon: Icon(Icons.restaurant),
              label: "Refeições",
            ),
            const BottomNavigationBarItem(
              icon: Icon(Icons.star),
              label: "Favoritos",
            ),
          ],
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}
