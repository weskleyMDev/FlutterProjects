import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_login.dart';
import '../utils/app_routes.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {
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
              Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
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
          Spacer(),
          ListTile(
            leading: const Icon(Icons.logout_sharp),
            title: const Text('Sair'),
            onTap: () async {
              await Provider.of<AuthLogin>(context, listen: false).logout();
              if (!context.mounted) return;
              Navigator.of(context).pushReplacementNamed(AppRoutes.authScreen);
            },
          ),
        ],
      ),
    );
  }
}
