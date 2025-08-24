import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/loading_screen.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../stores/stock.store.dart';

class StockList extends StatefulWidget {
  const StockList({
    super.key,
    required this.stockStore,
    required this.cartStore,
  });

  final StockStore stockStore;
  final CartStore cartStore;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late ReactionDisposer _errorReactionDisposer;

  @override
  void initState() {
    super.initState();
    _errorReactionDisposer = reaction((_) => widget.cartStore.errorMessage, (
      error,
    ) {
      if (error != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
        widget.cartStore.clearErrorMessage();
      }
    });
  }

  @override
  void dispose() {
    _errorReactionDisposer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final status = widget.stockStore.productStreamStatus;
        if (status == StreamStatus.waiting) {
          return const LoadingScreen();
        }
        final products = widget.stockStore.filteredProducts;
        if (products.isEmpty) {
          return Center(child: Text(S.of(context).no_products));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    key: ValueKey(product.id),
                    title: Text(product.name, overflow: TextOverflow.ellipsis),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).price}: R\$ ${product.price.replaceAll('.', ',')}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${S.of(context).stock}: ${product.amount.replaceAll('.', ',')} (${product.measure})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Observer(
                      builder: (_) {
                        final inCart = widget.cartStore.isProductInCart(
                          product,
                        );
                        return IconButton(
                          onPressed: inCart
                              ? null
                              : () {
                                  final success = widget.cartStore.addProduct(
                                    product,
                                  );
                                  if (success) {
                                    context.pushNamed('cart-home');
                                  }
                                },
                          icon: Icon(FontAwesome5.shopping_basket),
                          color: Colors.green,
                          tooltip: inCart
                              ? S.of(context).already_in_cart
                              : S.of(context).add_cart,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
