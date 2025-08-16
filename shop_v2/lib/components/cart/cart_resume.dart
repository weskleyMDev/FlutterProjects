import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/order/order.store.dart';

class CartResume extends StatefulWidget {
  const CartResume({
    super.key,
    required this.cartStore,
    required this.orderStore,
  });

  final CartStore cartStore;
  final OrderStore orderStore;

  @override
  State<CartResume> createState() => _CartResumeState();
}

class _CartResumeState extends State<CartResume> {
  @override
  void initState() {
    super.initState();
    widget.cartStore.calcCartValues();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Container(
          margin: const EdgeInsets.only(bottom: 8.0),
          child: Text(
            AppLocalizations.of(context)!.order_summary,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.subtotal}:',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Observer(
                  builder: (_) {
                    final subtotal = widget.cartStore.subtotal
                        .toStringAsFixed(2)
                        .replaceAll('.', ',');
                    return Text(
                      'R\$ $subtotal',
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.discount}:',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Observer(
                  builder: (_) {
                    final discount = widget.cartStore.discount
                        .toStringAsFixed(2)
                        .replaceAll('.', ',');
                    return Text(
                      'R\$ $discount',
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    '${AppLocalizations.of(context)!.shipping}:',
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Observer(
                  builder: (_) {
                    final shipping = widget.cartStore.shipping
                        .toStringAsFixed(2)
                        .replaceAll('.', ',');
                    return Text(
                      'R\$ $shipping',
                      overflow: TextOverflow.ellipsis,
                    );
                  },
                ),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 12.0, bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      '${AppLocalizations.of(context)!.total}:',
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Observer(
                    builder: (_) {
                      final total = widget.cartStore.total
                          .toStringAsFixed(2)
                          .replaceAll('.', ',');
                      return Text(
                        'R\$ $total',
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      );
                    },
                  ),
                ],
              ),
            ),
            Observer(
              builder: (_) {
                return FilledButton(
                  onPressed: widget.cartStore.length == 0
                      ? null
                      : () async {
                          try {
                            await widget.orderStore.saveOrder();
                            await widget.cartStore.clearCart();
                            if (!context.mounted) return;
                            context.goNamed('orders-screen');
                          } catch (e) {
                            ScaffoldMessenger.of(context).clearSnackBars();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                  child: Text(
                    AppLocalizations.of(context)!.confirm_order,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
