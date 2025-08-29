import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_bloc.dart';
import 'package:form_bloc/blocs/auth/auth_state.dart';
import 'package:form_bloc/models/app_user.dart';
import 'package:form_bloc/screens/admin_screen.dart';
import 'package:form_bloc/screens/loading_screen.dart';
import 'package:form_bloc/screens/login_screen.dart';
import 'package:form_bloc/screens/user_screen.dart';

class AuthManager extends StatefulWidget {
  const AuthManager({super.key});

  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (_, state) {
        if (state is AuthLoadingState || state is AuthInitialState) {
          return LoadingScreen();
        } else if (state is AuthLoggedInState) {
          final user = state.currentUser;
          if (user == null) return LoginScreen();
          return user.role == UserRole.user ? UserScreen() : AdminScreen();
        } else if (state is AuthLoggedOutState || state is AuthErrorState) {
          return const LoginScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
