import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/widgets/cart_items.dart';

import '../models/cart.dart';
import '../utils/capitalize.dart';

class CartScreen extends StatelessWidget with Capitalize {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Cart cart = Provider.of(context);
    final items = cart.items.values.toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize('carrinho'),
        ),
      ),
      body: cart.itemCount == 0
          ? Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    capitalize('carrinho vazio!!!'),
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
          : Column(
              children: <Widget>[
                Card(
                  margin: const EdgeInsets.all(25),
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
                          onPressed: () {},
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
                    itemBuilder: (context, index) => CartItems(items[index]),
                  ),
                ),
              ],
            ),
    );
  }
}
