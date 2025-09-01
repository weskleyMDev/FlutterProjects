import 'package:admin_shop/blocs/auth/auth_bloc.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = BlocProvider.of<AuthBloc>(context);
    final userName = authBloc.state.user?.name ?? '';
    return Scaffold(
      appBar: AppBar(
        title: Text('Bem vindo, $userName'),
        actions: [
          IconButton(
            onPressed: () => authBloc.add(SignOutRequested()),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              Center(child: Text(userName)),
              (state.status == AuthStatus.waiting)
                  ? const LoadingScreen()
                  : const SizedBox.shrink(),
            ],
          );
        },
      ),
    );
  }
}
