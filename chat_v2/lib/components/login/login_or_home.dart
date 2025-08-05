import 'package:chat_v2/models/app_user.dart';
import 'package:chat_v2/screens/home/home_screen.dart';
import 'package:chat_v2/screens/login/login_screen.dart';
import 'package:chat_v2/stores/form/login/login_form.store.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

class LoginOrHome extends StatefulWidget {
  const LoginOrHome({super.key});

  @override
  State<LoginOrHome> createState() => _LoginOrHomeState();
}

class _LoginOrHomeState extends State<LoginOrHome> {
  final loginStore = GetIt.instance<LoginFormStore>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<AppUser?>(
      stream: loginStore.userChanges,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
          case ConnectionState.waiting:
            return Center(child: CircularProgressIndicator());
          default:
            if (snapshot.hasData && snapshot.data != null) {
              return snapshot.data?.role == 'user'
                  ? HomeScreen()
                  : LoginScreen();
            } else {
              return LoginScreen();
            }
        }
      },
    );
  }
}
