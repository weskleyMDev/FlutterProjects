import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:seller_fribe/blocs/auth/auth_bloc.dart';

class UserDrawer extends StatelessWidget {
  const UserDrawer({super.key, required this.authBloc});

  final AuthBloc authBloc;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          DrawerHeader(
            child: SvgPicture.asset(
              'assets/images/logo.svg',
              width: 100,
              height: 100,
            ),
          ),
          ListTile(
            title: const Text('Venda'),
            onTap: () {
              // Handle profile tap
            },
          ),
          ListTile(
            title: const Text('Recibos'),
            onTap: () {
              // Handle settings tap
            },
          ),
          const Spacer(),
          ListTile(
            title: const Text('Sair'),
            onTap: () {
              GoRouter.of(context).pop();
              authBloc.add(const AuthLogoutRequested());
            },
          ),
        ],
      ),
    );
  }
}
