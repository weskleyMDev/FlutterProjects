import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/search_bar.dart';
import 'package:fribev2_app/components/stock_list.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';

class SalesHomePage extends StatefulWidget {
  const SalesHomePage({super.key});

  @override
  State<SalesHomePage> createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
  late ReactionDisposer _errorReactionDisposer;
  late final StockStore _stockStore;
  late final CartStore _cartStore;
  late final PaymentStore _paymentStore;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _stockStore = context.read<StockStore>()..fetchData();
    _cartStore = context.read<CartStore>();
    _paymentStore = context.read<PaymentStore>();
    _searchController = TextEditingController();
    _errorReactionDisposer = reaction((_) => _cartStore.errorMessage, (
      error,
    ) {
      if (error != null) {
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(error)));
        _cartStore.clearErrorMessage();
      }
    });
  }

  @override
  void dispose() {
    _errorReactionDisposer();
    _stockStore.disposeStock();
    _cartStore.clearCartStore();
    _paymentStore.clearPaymentStore();
    _searchController.dispose();
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
        final emptyCart = _cartStore.cartList.isEmpty;
        if (didPop) return;
        if (emptyCart) {
          context.pop();
          return;
        }
        final shouldExit = await _leaveDialog();
        if (shouldExit ?? false) {
          if (!context.mounted) return;
          context.pop();
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(S.of(context).new_sale),
          actions: [
            Observer(
              builder: (_) {
                return Badge.count(
                  count: _cartStore.cartList.length,
                  offset: Offset(0.0, 4.0),
                  child: IconButton(
                    onPressed: () {
                      context.pushNamed('cart-home');
                      _searchController.clear();
                      _stockStore.searchQuery = '';
                    },
                    icon: Icon(FontAwesome5.shopping_cart),
                    color: Colors.red,
                    tooltip: S.of(context).shopping_cart,
                  ),
                );
              },
            ),
          ],
          actionsPadding: const EdgeInsets.only(right: 10.0),
          centerTitle: true,
        ),
        body: StockList(stockStore: _stockStore, cartStore: _cartStore),
        bottomNavigationBar: CustomSearchBar(searchController: _searchController, stockStore: _stockStore),
      ),
    );
  }
}


