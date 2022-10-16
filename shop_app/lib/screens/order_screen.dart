import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/order_list.dart';
import '../utils/capitalize.dart';
import '../widgets/app_drawer.dart';
import '../widgets/order.dart';

class OrderScreen extends StatelessWidget with Capitalize {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final OrderList order = Provider.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          capitalize('meus pedidos'),
        ),
      ),
      body: ListView.builder(
        itemCount: order.itemsCount,
        itemBuilder: (context, index) => OrderWidget(order.items[index]),
      ),
      drawer: const AppDrawer(),
    );
  }
}
