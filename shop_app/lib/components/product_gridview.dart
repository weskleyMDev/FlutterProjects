import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../models/product_list.dart';
import 'product_item.dart';

class ProductGridView extends StatelessWidget {
  const ProductGridView({super.key, required this.showFavoriteOnly});

  final bool showFavoriteOnly;

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    final List<Product> items = showFavoriteOnly
        ? products.favoriteItems
        : products.items;
    return GridView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: items.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        value: items[i],
        child: ProductItem(),
      ),
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 200,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
      ),
    );
  }
}
