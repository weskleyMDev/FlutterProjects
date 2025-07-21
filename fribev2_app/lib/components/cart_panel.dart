import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../stores/cart.store.dart';

class CartPanel extends StatelessWidget {
  const CartPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Observer(
      builder: (context) {
        final products = cartStore.cartList.entries.toList();
        return Card(
          margin: const EdgeInsets.only(right: 12.0, bottom: 12.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Flexible(
                  child: Chip(
                    label: Text(
                      'TOTAL: R\$ ${cartStore.totalAmount.toStringAsFixed(2).replaceAll('.', ',')}',
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final entry = products[index];
                      final productId = entry.key;
                      final product = entry.value;
                      return ListTile(
                        title: Text(product.name),
                        subtitle: Text(
                          'x${product.quantity.toStringAsFixed(3).replaceAll('.', ',')}',
                        ),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'R\$ ${cartStore.subtotals[productId]?.toStringAsFixed(2).replaceAll('.', ',') ?? 'R\$ 0.00'}',
                              style: TextStyle(
                                fontSize: 14.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
