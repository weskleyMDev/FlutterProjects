import 'package:flutter/material.dart';

import '../models/user.dart';
import '../services/auth/auth_service_imp.dart';
import 'auth_screen.dart';
import 'home_screen.dart';
import 'loading_screen.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: AuthServiceImp().userChanges,
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
