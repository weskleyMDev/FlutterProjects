import 'package:flutter/material.dart';

import '../factorys/local_services_factory.dart';
import '../models/user.dart';
import '../services/authentication/auth_service.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthService localAuth = LocalServicesFactory.instance.createAuthService();
    return StreamBuilder<User?>(
      stream: localAuth.userChanges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return LoadingScreen();
        } else {
          return (snapshot.hasData) ? HomeScreen() : AuthScreen();
        }
      },
    );
  }
}
