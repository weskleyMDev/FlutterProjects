import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/home_drawer.dart';
import '../components/order_item.dart';
import '../models/order_list.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final orderList = Provider.of<OrderList>(
      context,
      listen: false,
    ).loadOrders();
    return Scaffold(
      drawer: HomeDrawer(),
      appBar: AppBar(title: const Text('Meus Pedidos')),
      body: FutureBuilder(
        future: orderList,
        builder: (ctx, snap) {
          if (snap.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            return Consumer<OrderList>(
              builder: (ctx, orders, child) => orders.orderCount == 0
                  ? child!
                  : ListView.builder(
                      itemCount: orders.orderCount,
                      itemBuilder: (ctx, i) {
                        final order = orders.orders[i];
                        return OrderItem(order: order);
                      },
                    ),
              child: Center(
                child: Text(
                  'Nenhum pedido realizado',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
