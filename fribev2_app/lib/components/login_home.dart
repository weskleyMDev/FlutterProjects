import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:fribev2_app/firebase_options.dart';
import 'package:provider/provider.dart';

import '../pages/admin_home_page.dart';
import '../pages/login_page.dart';
import '../pages/user_home_page.dart';
import '../stores/auth.store.dart';

class LoginOrHome extends StatelessWidget {
  const LoginOrHome({super.key});

  Future<void> init(BuildContext context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return FutureBuilder(
      future: init(context),
      builder: (context, asyncSnapshot) {
        switch (asyncSnapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return const Center(child: CircularProgressIndicator());
          default:
            return StreamBuilder(
              stream: authStore.userChanges,
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
      },
    );
  }
}
