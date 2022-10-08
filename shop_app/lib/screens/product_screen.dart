import 'package:flutter/material.dart';

import '../data/dummy_data.dart';
import '../models/product.dart';
import '../utils/capitalize.dart';
import '../widgets/product_item.dart';

class ProductsScreen extends StatelessWidget with Capitalize {
  ProductsScreen({super.key});

  final List<Product> loadedProducts = dummyProducts;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(capitalize('minha loja')),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: loadedProducts.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) => ProductItem(
          product: loadedProducts[index],
        ),
      ),
    );
  }
}
