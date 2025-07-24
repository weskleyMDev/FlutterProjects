import 'package:flutter/material.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../components/drawer_admin.dart';
import '../stores/auth.store.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final name = authStore.currentUser?.email.split('@')[0] ?? 'Usuário';
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, ${name.capitalize()}!')),
      drawer: const DrawerAdmin(),
      body: GridView(
        padding: const EdgeInsets.all(10.0),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 200.0,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10.0,
          mainAxisSpacing: 10.0,
        ),
        children: [
          ElevatedButton(
            onPressed: () => context.pushNamed('stock-home'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('ESTOQUE'),
          ),
          ElevatedButton(
            onPressed: () => context.pushNamed('receipts-home'),
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: const Text('RECIBOS'),
          ),
        ],
      ),
    );
  }
}
