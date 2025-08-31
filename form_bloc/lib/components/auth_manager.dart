import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_state.dart';
import 'package:form_bloc/models/app_user.dart';
import 'package:form_bloc/screens/admin_screen.dart';
import 'package:form_bloc/screens/login_screen.dart';
import 'package:form_bloc/screens/user_screen.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        final user = state.currentUser;
        final status = state.status ?? AuthStatus.success;
        if (user == null) {
          return const LoginScreen();
        }
        if (status == AuthStatus.success) {
          return user.role == UserRole.admin ? AdminScreen() : UserScreen();
        } else {
          return LoginScreen();
        }
      },
    );
  }
}
