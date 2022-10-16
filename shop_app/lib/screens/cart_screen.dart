import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/cart.dart';
import '../models/order_list.dart';
import '../utils/capitalize.dart';
import '../widgets/cart_item.dart';

class CartScreen extends StatelessWidget with Capitalize {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();
    final OrderList order = Provider.of(
      context,
      listen: false,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize('carrinho'),
        ),
      ),
      body: cart.itemCount == 0
          ? Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          capitalize('total'),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Chip(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          label: Text(
                            capitalize(
                                'R\$${cart.totalAmount.toStringAsFixed(2)}'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            )
          : Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 25,
                    horizontal: 15,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          capitalize('total'),
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Chip(
                          backgroundColor:
                              Theme.of(context).colorScheme.secondary,
                          label: Text(
                            capitalize(
                                'R\$${cart.totalAmount.toStringAsFixed(2)}'),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                        const Spacer(),
                        TextButton(
                          onPressed: () {
                            order.addOrder(cart);
                            cart.clear();
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all(Colors.green),
                          ),
                          child: Text(
                            capitalize('comprar'),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) =>
                        CartItemWidget(items[index]),
                  ),
                ),
              ],
            ),
    );
  }
}
