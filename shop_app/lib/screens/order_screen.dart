import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/home_drawer.dart';
import '../components/order_item.dart';
import '../models/order_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(context, listen: false);
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: LayoutBuilder(
        builder: (ctx, cont) {
          return orderList.orders.isEmpty
              ? Center(
                  child: Text(
                    'Nenhum pedido realizado',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                )
              : ListView.builder(
                  itemCount: orderList.orders.length,
                  itemBuilder: (ctx, i) {
                    final order = orderList.orders[i];
                    return OrderItem(order: order);
                  },
                );
        },
      ),
    );
  }
}
