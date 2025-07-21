import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
        return Padding(
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
                    return Container(
                      margin: const EdgeInsets.all(5.0),
                      child: Slidable(
                        startActionPane: ActionPane(
                          extentRatio: 0.25,
                          motion: BehindMotion(),
                          children: [
                            SlidableAction(
                              onPressed: (context) {
                                cartStore.removeItem(productId: productId);
                              },
                              backgroundColor: Colors.red,
                              icon: Icons.delete_outline,
                              label: 'Excluir',
                              padding: EdgeInsets.zero,
                            ),
                          ],
                        ),
                        child: Card(
                          margin: EdgeInsets.zero,
                          shape: RoundedRectangleBorder(),
                          child: ListTile(
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
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
