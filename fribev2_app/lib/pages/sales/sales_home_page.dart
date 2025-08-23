import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/stock_list.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/services/stock/firebase_stock_service.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class SalesHomePage extends StatelessWidget {
  const SalesHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => StockStore(FirebaseStockService())..fetchData(),
      dispose: (context, value) => value.disposeStock(),
      child: const SalesPage(),
    );
  }
}

class SalesPage extends StatefulWidget {
  const SalesPage({super.key});

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late final StockStore _stockStore;

  @override
  void initState() {
    super.initState();
    _stockStore = context.read<StockStore>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).new_sale),
        actions: [
          Badge.count(
            count: 0,
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
      body: StockList(stockStore: _stockStore),
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
    );
  }
}
