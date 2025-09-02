import 'package:admin_shop/blocs/orders/order_bloc.dart';
import 'package:admin_shop/blocs/users/user_bloc.dart';
import 'package:admin_shop/models/user_model.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:intl/intl.dart';

class ClientsTab extends StatefulWidget {
  const ClientsTab({super.key});

  @override
  State<ClientsTab> createState() => _ClientsTabState();
}

class _ClientsTabState extends State<ClientsTab> {
  late final OrderBloc _orderBloc;
  late final TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _orderBloc = BlocProvider.of<OrderBloc>(context);
    _searchController = TextEditingController()
      ..addListener(() {
        setState(() {
          _searchQuery = _searchController.text.toLowerCase();
        });
      });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _fetchOrdersForUsers(List<UserModel> users) {
    for (var user in users) {
      _orderBloc
        ..add(UserOrdersCountRequested(user.id))
        ..add(UserOrdersTotalRequested(user.id));
    }
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.compactSimpleCurrency(locale: locale);
    final quantity = NumberFormat.compact(locale: locale);
    return BlocBuilder<UserBloc, UserState>(
      builder: (context, userState) {
        if (userState.status == UserOverviewStatus.initial ||
            userState.status == UserOverviewStatus.loading) {
          return LoadingScreen();
        } else if (userState.status == UserOverviewStatus.success) {
          final users = userState.users
              .where((u) => u.name.toLowerCase().contains(_searchQuery.trim()))
              .toList();
          if (users.isEmpty) {
            return Center(child: Text('No users found!'));
          }
          if (users.isNotEmpty) _fetchOrdersForUsers(users);
          return Padding(
            padding: const EdgeInsets.all(12.0),
            child: ListView.separated(
              shrinkWrap: true,
              separatorBuilder: (context, index) => const Divider(),
              itemCount: users.length + 1,
              itemBuilder: (context, index) {
                if (index == 0) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        labelText: 'Buscar cliente',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        prefixIcon: Icon(FontAwesome5.search),
                      ),
                    ),
                  );
                }
                final user = users[index - 1];
                return BlocSelector<
                  OrderBloc,
                  OrderState,
                  Map<String, dynamic>
                >(
                  selector: (state) => {
                    'count': state.userOrdersCount[user.id] ?? 0,
                    'total': state.userOrdersTotal[user.id] ?? 0.0,
                  },
                  builder: (context, data) {
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text('Email: ${user.email}'),
                      trailing: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text('Pedidos: ${quantity.format(data['count'])}'),
                          Text('Gastos: ${currency.format(data['total'])}'),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
