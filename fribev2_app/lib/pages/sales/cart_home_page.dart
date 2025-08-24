import 'package:flutter/material.dart';
import 'package:fribev2_app/components/cart_panel.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:provider/provider.dart';

class CartHomePage extends StatefulWidget {
  const CartHomePage({super.key});

  @override
  State<CartHomePage> createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  late final CartStore _cartStore;
  @override
  void initState() {
    super.initState();
    _cartStore = context.read<CartStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(S.of(context).shopping_cart)),
      body: CartPanel(cartStore: _cartStore),
    );
  }
}
