import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/home_drawer.dart';
import '../components/product_gridview.dart';
import '../models/cart.dart';
import '../utils/app_routes.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

enum FilterOptions { all, favorites }

class _MyHomePageState extends State<MyHomePage> {
  bool _showFavoriteOnly = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: const Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cartScreen);
              },
            ),
            builder: (ctx, cart, child) => Badge.count(
              count: cart.itemCount,
              isLabelVisible: cart.itemCount > 0,
              textColor: Theme.of(context).textTheme.displaySmall?.color,
              child: child!,
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('Todos'),
              ),
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Favoritos'),
              ),
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorites) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGridView(showFavoriteOnly: _showFavoriteOnly),
      drawer: const HomeDrawer(),
    );
  }
}
