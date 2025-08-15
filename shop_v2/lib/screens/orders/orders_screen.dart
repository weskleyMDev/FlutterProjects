import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = GetIt.I.get<CartStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: HomeDrawer(),
      body: Observer(
        builder: (context) {
          cartStore.getCoupon('10OFF');
          return Center(child: Text(cartStore.discount.toString()));
        },
      ),
    );
  }
}
