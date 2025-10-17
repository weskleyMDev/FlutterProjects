import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
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
            leading: const Icon(Icons.point_of_sale),
            title: const Text('Venda'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).goNamed('home');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesome5.money_check_alt, size: 20.0),
            title: const Text('Vales'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).goNamed('pending_sales');
            },
          ),
          ListTile(
            leading: const Icon(FontAwesome5.receipt),
            title: const Text('Recibos'),
            onTap: () {
              Navigator.of(context).pop();
              GoRouter.of(context).goNamed('receipts');
            },
          ),
          const Spacer(),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Sair'),
                  onTap: () {
                    Navigator.of(context).pop();
                    authBloc.add(const AuthLogoutRequested());
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: Text(
                  'V 1.1.0',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
