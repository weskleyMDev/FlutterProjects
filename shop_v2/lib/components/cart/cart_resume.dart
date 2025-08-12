import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';

class CartResume extends StatelessWidget {
  const CartResume({super.key, required this.cartStore});

  final CartStore cartStore;

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
                Text('R\$ 0.00', overflow: TextOverflow.ellipsis),
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
                Text('R\$ 0.00', overflow: TextOverflow.ellipsis),
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
                Text('R\$ 0.00', overflow: TextOverflow.ellipsis),
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
                    ),
                  ),
                  Text('R\$ 0.00', overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Observer(
              builder: (_) {
                return FilledButton(
                  onPressed: cartStore.length == 0 ? null : () {},
                  child: Text(AppLocalizations.of(context)!.confirm_order),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
