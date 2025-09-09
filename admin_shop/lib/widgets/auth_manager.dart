import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/screens/home_screen.dart';
import 'package:admin_shop/screens/login_screen.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthManager extends StatelessWidget {
  const AuthManager({super.key});

  @override
  Widget build(BuildContext context) {
    Future<bool> hasConnection() async {
      try {
        final result = await Connectivity().checkConnectivity();
        return result.contains(ConnectivityResult.none);
      } catch (e) {
        return false;
      }
    }

    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.success) {
          final user = state.user;
          if (user != null) {
            return HomeScreen();
          }
        }
        if (state.status == AuthStatus.failure) {
          return FutureBuilder<bool>(
            future: hasConnection(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              } else if (snapshot.hasError || (snapshot.data ?? true)) {
                return const Scaffold(
                  body: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.wifi_off, size: 50),
                        Text('No internet connection!'),
                      ],
                    ),
                  ),
                );
              } else {
                return const LoginScreen();
              }
            },
          );
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
