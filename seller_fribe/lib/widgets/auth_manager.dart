import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';
import 'package:seller_fribe/screens/home_screen.dart';
import 'package:seller_fribe/screens/login_screen.dart';

class AuthManager extends StatefulWidget {
  const AuthManager({super.key});

  @override
  State<AuthManager> createState() => _AuthManagerState();
}

class _AuthManagerState extends State<AuthManager> {
  late final StreamSubscription<List<ConnectivityResult>>?
  _connectivitySubscription;

  bool _hasNoConnection = false;

  @override
  void initState() {
    super.initState();
    _connectivitySubscription = Connectivity().onConnectivityChanged.listen((
      results,
    ) {
      final noConnection =
          results.isEmpty || results.contains(ConnectivityResult.none);
      if (noConnection != _hasNoConnection) {
        setState(() {
          _hasNoConnection = noConnection;
        });
      }
    });

    _initializeConnectionStatus();
  }

  Future<void> _initializeConnectionStatus() async {
    final result = await Connectivity().checkConnectivity();
    setState(() {
      _hasNoConnection = result.contains(ConnectivityResult.none);
    });
  }

  @override
  void dispose() {
    _connectivitySubscription?.cancel();
    _connectivitySubscription = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_hasNoConnection) {
      return const Scaffold(
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.wifi_off, size: 80),
              Text('No internet connection!'),
            ],
          ),
        ),
      );
    }
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, state) {
        if (state.status == AuthStatus.initial) {
          return Scaffold(
            body: Container(
              color: Colors.black87,
              child: const Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state.status == AuthStatus.authenticated) {
          return const HomeScreen();
        } else {
          return const LoginScreen();
        }
      },
    );
  }
}
