import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({
    super.key,
    required this.cartStore,
    required this.stockStore,
  });

  final CartStore cartStore;
  final StockStore stockStore;

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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final cartItem = cartList[index];
                return Card(
                  child: ListTile(
                    title: Text(
                      '${cartItem.product!.name} - R\$${cartItem.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${S.of(context).quantity}: ${cartItem.quantity.toStringAsFixed(3).replaceAll('.', ',')}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: IconButton(
                      onPressed: () async {
                        final product = await widget.stockStore.getProductById(
                          id: cartItem.productId,
                        );
                        if (product == null) return;
                        final backQuantity =
                            (Decimal.parse(product.amount) +
                                    Decimal.parse(cartItem.quantity.toString()))
                                .toDouble();
                        await widget.stockStore.updateQuantityById(
                          id: cartItem.productId,
                          quantity: backQuantity.toString(),
                        );
                        widget.cartStore.removeProductById(cartItem.id);
                      },
                      icon: Icon(FontAwesome.trash_empty),
                      color: Colors.red,
                      tooltip: S.of(context).remove_product,
                    ),
                  ),
                );
              },
            ),
            const Divider(height: 28.0),
            Card(
              child: ListTile(
                title: Text(
                  'Total: R\$${widget.cartStore.total.toStringAsFixed(2).replaceAll('.', ',')}',
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
