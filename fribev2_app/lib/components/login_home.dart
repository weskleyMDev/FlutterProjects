import 'package:flutter/material.dart';

import '../pages/admin_home_page.dart';
import '../pages/login_page.dart';
import '../pages/user_home_page.dart';
import '../services/auth/local_auth_service.dart';

class LoginOrHome extends StatelessWidget {
  const LoginOrHome({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: LocalAuthService().userChanges,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
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
