import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/products_list.dart';
import '../utils/capitalize.dart';
import '../widgets/product_grid.dart';

enum FilterOptions {
  favorite,
  all,
}

class ProductsScreen extends StatelessWidget with Capitalize {
  ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsList>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize('minha loja'),
        ),
        actions: [
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
              if (value == FilterOptions.all) {
                provider.showAll();
              } else {
                provider.showFavorites();
              }
            },
          )
        ],
      ),
      body: const ProductGrid(),
    );
  }
}
