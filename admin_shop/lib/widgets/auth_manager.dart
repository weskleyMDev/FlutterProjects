import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/screens/home_screen.dart';
import 'package:admin_shop/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.success) {
          final user = state.user;
          if (user != null) {
            return HomeScreen();
          }
        }
        return LoginScreen();
      },
    );
  }
}
