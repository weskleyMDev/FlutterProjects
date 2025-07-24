import 'package:flutter/material.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:provider/provider.dart';

import '../components/user_drawer.dart';
import '../stores/auth.store.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    final name = authStore.currentUser?.email.split('@')[0].capitalize();
    return Scaffold(
      appBar: AppBar(title: Text('Bem vindo, $name')),
      drawer: UserDrawer(),
      body: Center(child: Text('USER HOME PAGE')),
    );
  }
}
