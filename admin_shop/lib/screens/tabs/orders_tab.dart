import 'package:admin_shop/blocs/orders/order_bloc.dart';
import 'package:admin_shop/blocs/users/user_bloc.dart';
import 'package:admin_shop/models/user_model.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:admin_shop/utils/capitalize_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class OrdersTab extends StatefulWidget {
  const OrdersTab({super.key});

  @override
  State<OrdersTab> createState() => _OrdersTabState();
}

class _OrdersTabState extends State<OrdersTab> {
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.compactSimpleCurrency(locale: locale);
    final date = DateFormat.yMMMMEEEEd(locale).add_Hm();
    return BlocBuilder<OrderBloc, OrderState>(
      builder: (context, state) {
        if (state.status == OrdersOverviewStatus.initial ||
            state.status == OrdersOverviewStatus.loading) {
          return const LoadingScreen();
        } else if (state.status == OrdersOverviewStatus.success) {
          final orders = state.orders;
          if (orders.isEmpty) {
            return const Center(child: Text('No orders found!'));
          }
          return ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                child: ExpansionTile(
                  title: Text(
                    'Pedido: #${order.id}',
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(date.format(order.createdAt).capitalize()),
                  children: [
                    ListTile(
                      title: BlocSelector<UserBloc, UserState, String>(
                        selector: (state) {
                          final user = state.users.firstWhere(
                            (user) => user.id == order.userId,
                            orElse: () => UserModel.empty(),
                          );
                          return user.name;
                        },
                        builder: (context, data) {
                          return Text(data);
                        },
                      ),
                      trailing: Text(
                        'Total: ${currency.format(order.total)}',
                        style: TextStyle(fontSize: 14.0),
                      ),
                    ),
                    ...order.products.map(
                      (product) => ListTile(
                        title: Text(
                          '${product.productId} (${product.size})',
                          style: TextStyle(fontSize: 14.0),
                        ),
                        trailing: Text(
                          'x ${product.quantity}',
                          style: TextStyle(fontSize: 14.0),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: Text('Something went wrong'));
        }
      },
    );
  }
}
