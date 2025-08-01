import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../stores/auth.store.dart';

class DrawerAdmin extends StatelessWidget {
  const DrawerAdmin({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);

    return Drawer(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: IntrinsicHeight(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    DrawerHeader(
                      child: Center(
                        child: SvgPicture.asset('assets/images/logo.svg'),
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.home_sharp),
                      title: const Text('Inicio'),
                      onTap: () => context.go('/'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.storage_sharp),
                      title: const Text('Estoque'),
                      onTap: () => context.goNamed('stock-home'),
                    ),
                    ListTile(
                      leading: const Icon(Icons.receipt_long_outlined),
                      title: const Text('Recibos'),
                      onTap: () => context.pushNamed('receipts-home'),
                    ),
                    Spacer(),
                    ListTile(
                      leading: const Icon(Icons.logout),
                      title: const Text('Sair'),
                      onTap: authStore.logout,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
