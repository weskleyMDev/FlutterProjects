import 'package:admin_shop/blocs/users/user_bloc.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';

class ClientsTab extends StatelessWidget {
  const ClientsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.compactSimpleCurrency(locale: locale);
    final quantity = NumberFormat.compact(locale: locale);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, state) {
        if (state.status == UserOverviewStatus.initial ||
            state.status == UserOverviewStatus.loading) {
          return LoadingScreen();
        } else if (state.status == UserOverviewStatus.success) {
          final users = state.users;
          if (users.isEmpty) {
            return Center(child: Text('No users found!'));
          }
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: 'Buscar cliente',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    prefixIcon: Icon(FontAwesome5.search),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ListView.separated(
                    shrinkWrap: true,
                    separatorBuilder: (context, index) => const Divider(),
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return ListTile(
                        title: Text(user.name),
                        subtitle: Text('Email: ${user.email}'),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('Pedidos: ${quantity.format(30)}'),
                            Text('Gastos: ${currency.format(30)}'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
