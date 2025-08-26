import 'package:flutter/material.dart';
import 'package:fribev2_app/components/cart_panel.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:fribev2_app/stores/sales.store.dart';
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
  late final PaymentStore _paymentStore;
  late final SalesStore _salesStore;

  @override
  void initState() {
    super.initState();
    _cartStore = context.read<CartStore>();
    _stockStore = context.read<StockStore>();
    _paymentStore = context.read<PaymentStore>();
    _salesStore = context.read<SalesStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).shopping_cart),
        centerTitle: true,
      ),
      body: CartPanel(
        cartStore: _cartStore,
        stockStore: _stockStore,
        paymentStore: _paymentStore,
        salesStore: _salesStore,
      ),
    );
  }
}
