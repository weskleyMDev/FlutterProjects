import 'package:flutter/material.dart';
import 'package:fribev2_app/components/loading_screen.dart';
import 'package:provider/provider.dart';

import '../pages/admin_home_page.dart';
import '../pages/login_page.dart';
import '../pages/user_home_page.dart';
import '../stores/auth.store.dart';

class LoginOrHome extends StatefulWidget {
  const LoginOrHome({super.key});

  @override
  State<LoginOrHome> createState() => _LoginOrHomeState();
}

class _LoginOrHomeState extends State<LoginOrHome> {
  @override
  Widget build(BuildContext context) {
    final authStore = context.read<AuthStore>();
    return StreamBuilder(
      stream: authStore.userChanges,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const LoadingScreen();
          default:
            if (snapshot.hasData && snapshot.data != null) {
              return snapshot.data?.role == 'user'
                  ? UserHomePage()
                  : AdminHomePage();
            } else {
              return const LoginPage();
            }
        }
      },
    );
  }
}
