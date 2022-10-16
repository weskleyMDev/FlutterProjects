import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/product.dart';
import '../utils/app_routes.dart';
import '../utils/capitalize.dart';

class ProductItem extends StatelessWidget with Capitalize {
  const ProductItem({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<Product>(
      context,
      listen: false,
    );
    final cart = Provider.of<Cart>(context);
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black54,
          leading: Consumer<Product>(
            builder: (context, product, _) => IconButton(
              onPressed: () {
                product.toggleFavorite();
              },
              icon: Icon(
                product.isFavorite ? Icons.favorite : Icons.favorite_border,
              ),
              color: Colors.orange,
            ),
          ),
          title: Text(
            capitalize(product.name),
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    capitalize('${product.name} adicionado ao carrinho!'),
                  ),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                    label: 'desfazer'.toUpperCase(),
                    onPressed: () {
                      cart.removeSingleItem(product.id);
                    },
                  ),
                ),
              );
            },
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Consumer<Product>(
            builder: (context, product, _) => Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            ),
          ),
          onTap: () => Navigator.of(context).pushNamed(
            AppRoutes.productDetails,
            arguments: product,
          ),
        ),
      ),
    );
  }
}
