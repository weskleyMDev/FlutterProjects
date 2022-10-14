import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../utils/capitalize.dart';
import '../widgets/badge.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  all,
  favorite,
}

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> with Capitalize {
  bool _showFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize('minha loja'),
        ),
        actions: [
          Consumer<Cart>(
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.shopping_cart_checkout_rounded),
              ),
            builder: (context, cart, child) => Badge(
              value: cart.itemCount.toString(),
              child: child!,
            ),
          ),
          PopupMenuButton(
            itemBuilder: (_) => [
              PopupMenuItem(
                value: FilterOptions.all,
                child: Text(
                  capitalize('ver todos'),
                ),
              ),
              PopupMenuItem(
                value: FilterOptions.favorite,
                child: Text(
                  capitalize('ver favoritos'),
                ),
              ),
            ],
            onSelected: (FilterOptions value) {
              setState(() {
                if (value == FilterOptions.favorite) {
                  _showFavorites = true;
                } else {
                  _showFavorites = false;
                }
              });
            },
          ),
        ],
      ),
      body: ProductGrid(_showFavorites),
    );
  }
}
