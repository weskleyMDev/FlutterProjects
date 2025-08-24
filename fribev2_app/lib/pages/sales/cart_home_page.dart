import 'package:flutter/material.dart';
import 'package:fribev2_app/components/cart_panel.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:provider/provider.dart';

class CartHomePage extends StatefulWidget {
  const CartHomePage({super.key});

  @override
  State<CartHomePage> createState() => _CartHomePageState();
}

class _CartHomePageState extends State<CartHomePage> {
  late final CartStore _cartStore;
  late final StockStore _stockStore;

  @override
  void initState() {
    super.initState();
    _cartStore = context.read<CartStore>();
    _stockStore = context.read<StockStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shopping_cart),
        centerTitle: true,
      ),
      body: CartPanel(cartStore: _cartStore, stockStore: _stockStore),
    );
  }
}
