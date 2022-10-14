import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
            onPressed: () {},
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
