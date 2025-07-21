import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../components/cart_panel.dart';
import '../../components/drawer_admin.dart';
import '../../components/sales_panel.dart';
import '../../stores/cart.store.dart';

class SalesHomePage extends StatelessWidget {
  const SalesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('VENDAS'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                cartStore.clear();
              },
              icon: Icon(Icons.refresh_outlined),
              iconSize: 26.0,
            ),
          ),
        ],
      ),
      drawer: DrawerAdmin(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SalesPanel()),
          const VerticalDivider(width: 1.0, thickness: 2.0),
          Expanded(child: CartPanel()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        label: Text('FINALIZAR VENDA'),
        extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
        icon: Icon(Icons.point_of_sale_outlined),
      ),
    );
  }
}
