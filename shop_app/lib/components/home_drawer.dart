import 'package:flutter/material.dart';

import '../utils/app_routes.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          DrawerHeader(child: Center(child: Text('Bem-vindo!'.toUpperCase()))),
          ListTile(
            leading: const Icon(Icons.shopify_sharp),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.homeScreen);
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_basket_sharp),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(AppRoutes.orders);
            },
          ),
          ListTile(
            leading: const Icon(Icons.storage_sharp),
            title: const Text('Produtos'),
            onTap: () {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.productScreen);
            },
          ),
        ],
      ),
    );
  }
}
