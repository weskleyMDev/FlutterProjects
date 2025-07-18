import 'package:flutter/material.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:provider/provider.dart';

import '../components/drawer_admin.dart';
import '../stores/auth.store.dart';

class AdminHomePage extends StatelessWidget {
  const AdminHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context);
    final name = authStore.currentUser?.email.split('@')[0] ?? 'Usuário';
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, ${name.capitalize()}!')),
      drawer: const DrawerAdmin(),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return SingleChildScrollView(
            child: ConstrainedBox(
              constraints: BoxConstraints(minHeight: constraints.maxHeight),
              child: Center(child: Text('Welcome to the Admin Home Page')),
            ),
          );
        },
      ),
    );
  }
}
