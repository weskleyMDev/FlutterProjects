import 'dart:io';

import 'package:flutter/material.dart';

import '../services/auth/auth_service_imp.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: FileImage(
                File(AuthServiceImp().currentUser!.imageUrl),
              ),
            ),
            ElevatedButton(
              onPressed: () => AuthServiceImp().signout(),
              child: const Text('Sign out'),
            ),
          ],
        ),
      ),
    );
  }
}
