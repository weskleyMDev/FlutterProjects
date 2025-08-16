import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/components/cart/cart_list.dart';
import 'package:shop_v2/components/cart/cart_resume.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/cart/cart.store.dart';
import 'package:shop_v2/stores/order/order.store.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final cartStore = GetIt.instance<CartStore>();
  final orderStore = GetIt.I.get<OrderStore>();
  late final TextEditingController _textController;
  late final ExpansibleController _controller;

  @override
  void initState() {
    cartStore.calcCartValues();
    _textController = TextEditingController();
    _controller = ExpansibleController();
    super.initState();
  }

  @override
  void dispose() {
    cartStore.resetCart();
    _textController.dispose();
    _controller.dispose();
    super.dispose();
  }

  Future<void> _submitCoupon() async {
    try {
      if (_textController.text.trim().isEmpty) return;
      await cartStore.getCoupon(_textController.text.trim().toUpperCase());
      cartStore.calcCartValues();
      orderStore.data['coupon'] = _textController.text.trim().toUpperCase();
      _controller.collapse();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).clearSnackBars();
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
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
            child: Observer(
              builder: (_) {
                return ExpansionTile(
                  key: ValueKey('coupon_box'),
                  controller: _controller,
                  leading: Icon(FontAwesome.ticket),
                  title: Text(
                    AppLocalizations.of(context)!.promo_code,
                    overflow: TextOverflow.ellipsis,
                  ),
                  enabled: cartStore.length > 0,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        key: ValueKey('coupon_code'),
                        controller: _textController,
                        decoration: InputDecoration(
                          label: Text(AppLocalizations.of(context)!.promo_code),
                          suffixIcon: IconButton(
                            onPressed: _submitCoupon,
                            icon: Icon(FontAwesome5.check_circle),
                          ),
                        ),
                        onSubmitted: (_) async => await _submitCoupon(),
                      ),
                    ),
                  ],
                );
              },
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
          CartResume(cartStore: cartStore, orderStore: orderStore),
        ],
      ),
    );
  }
}
