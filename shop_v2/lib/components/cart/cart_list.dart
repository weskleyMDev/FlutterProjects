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
                  key: ValueKey(cartItem.id),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(right: 10.0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12.0),
                            child: Image.network(
                              cartItem.product?.images[0] ?? '',
                              height: 100.0,
                              width: 100.0,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                cartItem.product?.title[locale] ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${AppLocalizations.of(context)!.size}: ${cartItem.size}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'R\$ ${cartItem.product?.price.toStringAsFixed(2).replaceAll('.', ',')}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    height: 18.0,
                                    width: 18.0,
                                    margin: const EdgeInsets.only(right: 8.0),
                                    child: IconButton(
                                      onPressed: cartItem.quantity == 1
                                          ? null
                                          : () {
                                              cartStore.decrementQuantity(
                                                cartItem,
                                              );
                                            },
                                      padding: EdgeInsets.zero,
                                      iconSize: 18.0,
                                      icon: Icon(Icons.remove),
                                    ),
                                  ),
                                  Text(cartItem.quantity.toString()),
                                  Container(
                                    height: 18.0,
                                    width: 18.0,
                                    margin: const EdgeInsets.only(left: 8.0),
                                    child: IconButton(
                                      onPressed: () {
                                        cartStore.incrementQuantity(cartItem);
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
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: IconButton(
                            onPressed: () => cartStore.removeById(
                              cartItem.id,
                              cartItem.userId,
                            ),
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
                      ],
                    ),
                  ),
                );
              },
            );
        }
      },
    );
  }
}
