import 'package:flutter/material.dart';

import '../models/product.dart';
import '../utils/capitalize.dart';

class ProductDetails extends StatelessWidget with Capitalize {
  const ProductDetails({super.key});

  @override
  Widget build(BuildContext context) {
  final Product product = ModalRoute.of(context)!.settings.arguments as Product;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize(product.title),
        ),
      ),
      body: Center(
        child: Text(
          capitalize('detalhes do produto'),
        ),
      ),
    );
  }
}
