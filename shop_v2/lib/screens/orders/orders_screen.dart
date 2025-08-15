import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/products/products.store.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartStore = GetIt.I.get<CartStore>();
    final productStore = GetIt.I.get<ProductsStore>();
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: HomeDrawer(),
      body: Observer(
        builder: (context) {
          return Center(
            child: ListView.builder(
              itemCount: cartStore.cartItems.length,
              itemBuilder: (context, index) {
                final cartItem = cartStore.cartItems[index];
                final product = productStore.productsList.firstWhere(
                  (element) => element.id == cartItem.productId,
                );

                return ListTile(title: Text(product.price.toString()));
              },
            ),
          );
        },
      ),
    );
  }
}
