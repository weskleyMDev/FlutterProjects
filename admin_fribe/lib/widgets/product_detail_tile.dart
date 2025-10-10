import 'package:admin_fribe/models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProductDetailTile extends StatelessWidget {
  const ProductDetailTile({
    super.key,
    required this.product,
    required this.currencyFormat,
    required this.numberFormat,
  });

  final ProductModel product;
  final NumberFormat currencyFormat;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.pushNamed('edit-product', extra: product),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.limeAccent,
                  ),
                ),
                Text(
                  currencyFormat.format(double.tryParse(product.price) ?? 0),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.limeAccent,
                  ),
                ),
              ],
            ),
            Text(
              'ID: ${product.id}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Text(
              'Stock: ${numberFormat.format(double.tryParse(product.amount) ?? 0)}(${product.measure})',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
