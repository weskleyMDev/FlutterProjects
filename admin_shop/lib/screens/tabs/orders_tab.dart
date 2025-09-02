import 'package:admin_shop/blocs/orders/order_bloc.dart';
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
          return ListView.separated(
            shrinkWrap: true,
            itemCount: orders.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final order = orders[index];
              return ListTile(
                title: Text('Pedido: #${order.id}'),
                subtitle: Text(date.format(order.createdAt).capitalize()),
                trailing: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'Total: ${currency.format(order.total)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
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
