import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({super.key, required this.cartStore});

  final CartStore cartStore;

  @override
  State<CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final cartList = widget.cartStore.cartList;
        if (cartList.isEmpty) {
          return Center(child: SelectableText(S.of(context).no_products));
        }
        return ListView(
          children: [
            ListView.builder(
              itemCount: cartList.length,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final cartItem = cartList[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      '${cartItem.product!.name} - R\$${cartItem.subtotal.toStringAsFixed(2)}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${S.of(context).quantity}: ${cartItem.quantity.toString()}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () {},
                      icon: Icon(FontAwesome.trash_empty),
                    ),
                  ),
                );
              },
            ),
            const Divider(height: 28.0),
            Card(
              child: ListTile(
                title: Text(
                  'Total: ${widget.cartStore.total.toStringAsFixed(2)}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Divider(height: 28.0),
            FilledButton(onPressed: () {}, child: Text('Finalizar Pedido')),
          ],
        );
      },
    );
  }
}
