import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/models/product_model.dart';

class ProductTile extends StatelessWidget {
  const ProductTile({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final amount = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 3,
    );
    final currency = NumberFormat.simpleCurrency(locale: locale);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 4.0),
      child: Chip(
        padding: const EdgeInsets.all(12.0),
        label: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(product.name, style: const TextStyle(fontSize: 18.0)),
                Text(
                  currency.format(double.parse(product.price)),
                  style: const TextStyle(fontSize: 16.0),
                ),
              ],
            ),
            Text(
              'Estoque: ${amount.format(double.parse(product.amount))} (${product.measure})',
            ),
          ],
        ),
      ),
    );
  }
}
