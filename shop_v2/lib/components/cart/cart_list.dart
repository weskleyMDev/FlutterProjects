import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';

class CartList extends StatelessWidget {
  const CartList({super.key, required this.cartStore, required this.locale});

  final CartStore cartStore;
  final String locale;

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (context) {
        final status = cartStore.status;
        switch (status) {
          case StreamStatus.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            final cartItems = cartStore.cartItems;
            if (cartItems.isEmpty) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.no_data_found,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }
            return ListView.builder(
              shrinkWrap: true,
              itemCount: cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartItems[index];
                return Card(
                  child: Stack(
                    children: [
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 8.0),
                        title: Text(
                          cartItem.product.title[locale] ?? '',
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              '${AppLocalizations.of(context)!.size}: ${cartItem.size}',
                            ),
                            Text('R\$ ${cartItem.product.price}'),
                            Row(
                              children: [
                                Container(
                                  height: 18.0,
                                  width: 18.0,
                                  margin: const EdgeInsets.only(right: 8.0),
                                  child: Observer(
                                    builder: (_) {
                                      return IconButton(
                                        onPressed: cartStore.quantity == 1
                                            ? null
                                            : () {
                                                cartStore.quantity =
                                                    cartItem.quantity;
                                                cartStore.decrementQuantity();
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(cartItem.userId)
                                                    .collection('cart')
                                                    .doc(cartItem.id)
                                                    .update({
                                                      'quantity':
                                                          cartStore.quantity,
                                                    });
                                              },
                                        padding: EdgeInsets.zero,
                                        iconSize: 18.0,
                                        icon: Icon(Icons.remove),
                                      );
                                    },
                                  ),
                                ),
                                Text(cartItem.quantity.toString()),
                                Container(
                                  height: 18.0,
                                  width: 18.0,
                                  margin: const EdgeInsets.only(left: 8.0),
                                  child: IconButton(
                                    onPressed: () {
                                      cartStore.quantity = cartItem.quantity;
                                      cartStore.incrementQuantity();
                                      FirebaseFirestore.instance
                                          .collection('users')
                                          .doc(cartItem.userId)
                                          .collection('cart')
                                          .doc(cartItem.id)
                                          .update({
                                            'quantity': cartStore.quantity,
                                          });
                                    },
                                    padding: EdgeInsets.zero,
                                    iconSize: 18.0,
                                    icon: Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 5,
                        child: SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: IconButton(
                            onPressed: () {},
                            iconSize: 20.0,
                            icon: Icon(
                              FontAwesome.trash_empty,
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.zero,
                            tooltip: AppLocalizations.of(
                              context,
                            )!.remove_from_cart,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
        }
      },
    );
  }
}
