import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/app_routes.dart';
import '../utils/capitalize.dart';

class ProductItem extends StatelessWidget with Capitalize {
  const ProductItem({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          title: Text(
            capitalize(product.title),
            textAlign: TextAlign.center,
          ),
          backgroundColor: Colors.black38,
          leading: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.favorite),
            color: Theme.of(context).colorScheme.secondary,
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: const Icon(Icons.shopping_cart),
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        child: GestureDetector(
          child: Image.network(
            product.imageUrl,
            fit: BoxFit.cover,
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
