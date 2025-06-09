import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/utils/capitalize.dart';

import '../models/cart_item.dart';
import '../models/order.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order});

  final Order order;

  @override
  Widget build(BuildContext context) {
    final String date = order.date != null
        ? DateFormat(
            'E dd/MM/y H:mm:ss',
            'pt_BR',
          ).format(order.date!).capitalize().replaceAll(".", ",")
        : 'Data não disponível';
    final List<CartItem> products = order.products ?? [];
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
      child: ExpansionTile(
        title: Text(
          'Pedido: ${order.id?.toUpperCase()}',
          style: Theme.of(context).textTheme.titleMedium,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text("Data: $date"),
            Text(
              'Total: R\$ ${order.total?.replaceAll('.', ',')}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
        children: [
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: products.length,
            itemBuilder: (ctx, i) {
              final CartItem product = products[i];
              final String subtotal =
                  (Decimal.parse(product.quantity) *
                          Decimal.parse(product.price))
                      .toStringAsFixed(2);
              return ListTile(
                title: Text(product.name),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Quantidade: ${product.quantity}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      'Subtotal: R\$ ${subtotal.replaceAll('.', ',')}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
