import 'package:flutter/material.dart';

import '../../components/cart_panel.dart';
import '../../components/drawer_admin.dart';
import '../../components/sales_panel.dart';

class SalesHomePage extends StatelessWidget {
  const SalesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('VENDAS')),
      drawer: DrawerAdmin(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SalesPanel()),
          const SizedBox(width: 10.0),
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
