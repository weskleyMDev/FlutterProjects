import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/stock_list.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SalesHomePage extends StatefulWidget {
  const SalesHomePage({super.key});

  @override
  State<SalesHomePage> createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
  late final StockStore _stockStore;
  late final CartStore _cartStore;

  @override
  void initState() {
    super.initState();
    _stockStore = context.read<StockStore>()..fetchData();
    _cartStore = context.read<CartStore>();
  }

  @override
  void dispose() {
    _stockStore.disposeStock();
    _cartStore.clearCart();
    super.dispose();
  }

  Future<bool?> _leaveDialog() => showDialog<bool>(
    context: context,
    builder: (_) => AlertDialog(
      title: Text(S.of(context).cart_dialog_title),
      content: Text(S.of(context).cart_dialog_body),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(S.of(context).cancel),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(S.of(context).leave),
        ),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) async {
        if (!didPop) {
          final shouldExit = await _leaveDialog();
          if (shouldExit ?? false) {
            if (!context.mounted) return;
            context.pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).new_sale),
          actions: [
            Badge.count(
              count: _cartStore.cartList.length,
              offset: Offset(0.0, 4.0),
              child: IconButton(
                onPressed: () => context.pushNamed('cart-home'),
                icon: Icon(FontAwesome5.shopping_cart),
                color: Colors.red,
                tooltip: S.of(context).shopping_cart,
              ),
            ),
          ],
          actionsPadding: const EdgeInsets.only(right: 10.0),
          centerTitle: true,
        ),
        body: StockList(stockStore: _stockStore, cartStore: _cartStore),
        bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: const EdgeInsets.only(left: 4.0, right: 4.0, bottom: 8.0),
            child: TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                label: Text(
                  S.of(context).search,
                  overflow: TextOverflow.ellipsis,
                ),
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) => _stockStore.searchQuery = value,
            ),
          ),
        ),
      ),
    );
  }
}
