import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../stores/auth.store.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(authStore.currentUser?.email ?? 'User Home'),
        actions: [
          IconButton(
            onPressed: authStore.logout,
            icon: Icon(Icons.exit_to_app_sharp),
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.add)),
        ],
      ),
    );
  }
}
