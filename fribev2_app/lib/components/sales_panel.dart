import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

import '../stores/cart.store.dart';
import '../stores/stock.store.dart';

const List<String> list = ['teste 1', 'teste 2', 'teste 3'];

class SalesPanel extends StatelessWidget {
  const SalesPanel({super.key});

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    final cartStore = Provider.of<CartStore>(context);
    return Observer(
      builder: (context) {
        final future = stockStore.productsFuture;
        final products = stockStore.filteredProducts;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Flexible(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 4.0,
                    right: 4.0,
                    bottom: 8.0,
                  ),
                  child: TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('Buscar'),
                      prefixIcon: Icon(Icons.search),
                    ),
                    onChanged: (value) => stockStore.searchQuery = value,
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: (future == null || future.status == FutureStatus.pending)
                    ? const Center(child: CircularProgressIndicator())
                    : (products.isEmpty)
                    ? const Center(child: Text('Nenhum produto encontrado!'))
                    : ListView.builder(
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          final product = products[index];
                          return Card(
                            shape: RoundedRectangleBorder(),
                            child: ListTile(
                              title: Text(
                                product.name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Text(
                                'R\$ ${double.parse(product.price).toStringAsFixed(2).replaceAll('.', ',')} (${product.measure})',
                              ),
                              trailing: ElevatedButton.icon(
                                onPressed: () {
                                  cartStore.addItem(product: product);
                                },
                                label: Icon(Icons.add_outlined),
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
