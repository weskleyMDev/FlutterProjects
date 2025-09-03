import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/auth/auth.store.dart';
import 'package:shop_v2/stores/order/order.store.dart';
import 'package:transparent_image/transparent_image.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final orderStore = GetIt.I.get<OrderStore>();
  final authStore = GetIt.I.get<AuthStore>();

  @override
  void initState() {
    super.initState();
    orderStore.fetchOrders();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      drawer: HomeDrawer(),
      body: Observer(
        builder: (context) {
          final status = orderStore.orderStatus;
          if (status == StreamStatus.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else {
            final orders = orderStore.orders;
            if (orders.isEmpty) {
              return const Center(child: Text('No orders found'));
            }
            return ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                final date = DateFormat(
                  'EEEE, d/MM/y HH:mm',
                  'pt_BR',
                ).format(order.createdAt);
                return Card(
                  child: ExpansionTile(
                    leading: CircleAvatar(child: Text('${order.status}')),
                    title: Text(order.id),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(date.toUpperCase()[0] + date.substring(1)),
                        Text('Total: R\$ ${order.total.toStringAsFixed(2)}'),
                      ],
                    ),
                    children: [
                      FutureBuilder(
                        future: orderStore.fetchProductsForOrder(
                          order.products,
                        ),
                        builder: (context, snapshot) {
                          switch (snapshot.connectionState) {
                            case ConnectionState.none:
                            case ConnectionState.waiting:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            default:
                              if (snapshot.hasError) {
                                return Center(
                                  child: Text(snapshot.error.toString()),
                                );
                              }
                              final products = snapshot.data ?? [];
                              if (products.isEmpty) {
                                return const Center(
                                  child: Text('No products found'),
                                );
                              }
                              return ListView.builder(
                                itemCount: products.length,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final product = products[index];
                                  final locale = Localizations.localeOf(
                                    context,
                                  ).languageCode;
                                  return ListTile(
                                    leading: ClipOval(
                                      child: FadeInImage.memoryNetwork(
                                        placeholder: kTransparentImage,
                                        image: product.product.images[0],
                                        fit: BoxFit.cover,
                                        width: 50,
                                        height: 50,
                                      ),
                                    ),
                                    title: Text(
                                      product.product.title[locale] ?? 'Error',
                                    ),
                                    subtitle: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${AppLocalizations.of(context)!.size}: ${product.size}',
                                        ),
                                        Text(
                                          '${AppLocalizations.of(context)!.quantity}: ${product.quantity}',
                                        ),
                                      ],
                                    ),
                                  );
                                },
                              );
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
