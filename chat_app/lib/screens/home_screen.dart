import 'dart:io';

import 'package:flutter/material.dart';

import '../factorys/local_services_factory.dart';
import '../factorys/services_factory.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ServicesFactory localServices = LocalServicesFactory();
    final localAuth = localServices.createAuthService();
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(
                File(localAuth.currentUser!.imageUrl),
              ),
            ),
            ElevatedButton(
              onPressed: () => localAuth.signout(),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
