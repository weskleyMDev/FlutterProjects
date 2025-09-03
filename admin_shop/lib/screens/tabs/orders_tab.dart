import 'package:admin_shop/blocs/orders/order_bloc.dart';
import 'package:admin_shop/blocs/products/product_bloc.dart';
import 'package:admin_shop/blocs/users/user_bloc.dart';
import 'package:admin_shop/models/product_model.dart';
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
      builder: (context, orderState) {
        if (orderState.status == OrdersOverviewStatus.initial ||
            orderState.status == OrdersOverviewStatus.loading) {
          return const LoadingScreen();
        } else if (orderState.status == OrdersOverviewStatus.success) {
          final orders = orderState.orders;
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
                  childrenPadding: const EdgeInsets.symmetric(horizontal: 16.0),
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        BlocSelector<UserBloc, UserState, String>(
                          selector: (userState) {
                            final user = userState.users.firstWhere(
                              (user) => user.id == order.userId,
                              orElse: () => UserModel.empty(),
                            );
                            return user.name;
                          },
                          builder: (context, userName) {
                            return Text(
                              userName,
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            );
                          },
                        ),
                        Text(
                          'Total: ${currency.format(order.total)} (${order.coupon ?? 'Sem Cupom'})',
                          style: TextStyle(
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12.0),
                    ...order.products.map((product) {
                      final productBloc = BlocProvider.of<ProductBloc>(context);
                      final alreadyLoaded = productBloc.state.productsByCategory
                          .containsKey(product.category);
                      if (!alreadyLoaded) {
                        productBloc.add(
                          ProductsOverviewSubscriptionRequested(
                            product.category,
                          ),
                        );
                      }
                      return BlocBuilder<ProductBloc, ProductState>(
                        builder: (context, productState) {
                          final products =
                              productState.productsByCategory[product
                                  .category] ??
                              [];
                          final productModel = products.firstWhere(
                            (p) => p.id == product.productId,
                            orElse: () => ProductModel.empty(),
                          );
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '${productModel.title[locale]} (${product.size})',
                                style: TextStyle(fontSize: 12.0),
                              ),
                              Text(
                                'x ${product.quantity}',
                                style: TextStyle(fontSize: 12.0),
                              ),
                            ],
                          );
                        },
                      );
                    }),
                    const SizedBox(height: 12.0),
                    Row(
                      children: [
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                              shape: RoundedRectangleBorder(),
                            ),
                            onPressed: () {},
                            child: Text('Excluir'),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              shape: RoundedRectangleBorder(),
                            ),
                            onPressed: () {},
                            child: Text('Regredir'),
                          ),
                        ),
                        Expanded(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.green,
                              shape: RoundedRectangleBorder(),
                            ),
                            onPressed: () {},
                            child: Text('Avançar'),
                          ),
                        ),
                      ],
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
