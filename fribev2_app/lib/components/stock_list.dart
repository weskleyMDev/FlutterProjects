import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/loading_screen.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:mobx/mobx.dart';

import '../stores/stock.store.dart';

class StockList extends StatefulWidget {
  const StockList({super.key, required this.stockStore});

  final StockStore stockStore;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
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
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesome5.shopping_basket),
                      color: Colors.green,
                      tooltip: S.of(context).add_cart,
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
