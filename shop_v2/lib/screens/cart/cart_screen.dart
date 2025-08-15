import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/components/cart/cart_list.dart';
import 'package:shop_v2/components/cart/cart_resume.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartStore = GetIt.instance<CartStore>();

  @override
  void initState() {
    cartStore.calcCartValues();
    super.initState();
  }

  @override
  void dispose() {
    cartStore.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.my_cart),
        actions: [
          Observer(
            builder: (context) {
              return Text(
                AppLocalizations.of(context)!.item(cartStore.length),
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 16.0),
              );
            },
          ),
        ],
        actionsPadding: const EdgeInsets.only(right: 10),
      ),
      body: ListView(
        children: [
          CartList(cartStore: cartStore, locale: locale),
          Card(
            child: ListTile(
              leading: Icon(FontAwesome.ticket),
              title: Text(
                AppLocalizations.of(context)!.promo_code,
                overflow: TextOverflow.ellipsis,
              ),
              trailing: SizedBox(
                height: 24.0,
                width: 24.0,
                child: Observer(
                  builder: (_) {
                    return IconButton(
                      onPressed: cartStore.length > 0 ? () {} : null,
                      icon: Icon(Icons.add),
                      padding: EdgeInsets.zero,
                    );
                  },
                ),
              ),
            ),
          ),
          Card(
            child: Observer(
              builder: (_) {
                return ExpansionTile(
                  leading: Icon(FontAwesome.location),
                  title: Text(
                    AppLocalizations.of(context)!.shipping_calculator,
                    overflow: TextOverflow.ellipsis,
                  ),
                  enabled: cartStore.length > 0,
                );
              },
            ),
          ),
          CartResume(cartStore: cartStore),
        ],
      ),
    );
  }
}
