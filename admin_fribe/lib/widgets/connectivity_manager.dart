import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../blocs/connectivity/connectivity_bloc.dart';

class ConnectivityManager extends StatelessWidget {
  const ConnectivityManager({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final connectivityState = context.watch<ConnectivityBloc>().state;
    switch (connectivityState.status) {
      case ConnectivityStatus.unknown:
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      case ConnectivityStatus.connected:
        return child;
      case ConnectivityStatus.disconnected:
        return const Scaffold(
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.wifi_off, size: 80),
                SizedBox(height: 16),
                Text('No Internet Connection'),
              ],
            ),
          ),
        );
    }
  }
}
