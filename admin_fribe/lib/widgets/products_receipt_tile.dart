import 'package:flutter/material.dart';

class ProductsReceiptTile extends StatelessWidget {
  const ProductsReceiptTile({
    super.key,
    required this.productName,
    required this.quantity,
    required this.subtotal,
  });

  final String productName;
  final num quantity;
  final String subtotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$productName x$quantity',
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12.0),
        ),
        Text(
          subtotal,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontSize: 12.0),
        ),
      ],
    );
  }
}
