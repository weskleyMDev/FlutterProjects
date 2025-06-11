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
    return auth.isAuth ? MyHomePage() : LoginScreen();
  }
}
