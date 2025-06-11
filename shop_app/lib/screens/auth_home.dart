import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth_login.dart';
import 'home_screen.dart';
import 'login_screen.dart';

class AuthOrHome extends StatelessWidget {
  const AuthOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthLogin>(context);
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error}'));
        } else {
          return auth.isAuth ? MyHomePage() : LoginScreen();
        }
      },
    );
  }
}
