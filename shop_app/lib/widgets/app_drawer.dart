import 'package:flutter/material.dart';
import 'package:shop_app/utils/app_routes.dart';

import '../utils/capitalize.dart';

class AppDrawer extends StatelessWidget with Capitalize {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          AppBar(
            title: Text(
              capitalize('bem vindo usuário'),
            ),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopify_rounded),
            title: Text(
              capitalize('loja'),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AppRoutes.home,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shopping_basket_rounded),
            title: Text(
              capitalize('pedidos'),
            ),
            onTap: () => Navigator.of(context).pushReplacementNamed(
              AppRoutes.orders,
            ),
          ),
        ],
      ),
    );
  }
}
