import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/components/products/products_grid.dart';
import 'package:shop_v2/components/products/products_list.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:shop_v2/stores/products/products.store.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({super.key});

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {

  @override
  void dispose() {
    GetIt.instance<ProductsStore>().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsStore = GetIt.instance<ProductsStore>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(productsStore.categoryLabel ?? 'Error'),
          centerTitle: true,
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(FontAwesome5.th_large)),
              Tab(icon: Icon(FontAwesome5.list_ul)),
            ],
          ),
        ),
        body: StreamBuilder<List<ProductModel>>(
          stream: productsStore.productsList,
          builder: (context, snapshot) {
            switch (snapshot.connectionState) {
              case ConnectionState.none:
              case ConnectionState.waiting:
                return const Center(child: CircularProgressIndicator());
              default:
                if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(
                    child: Text(AppLocalizations.of(context)!.no_data_found),
                  );
                } else {
                  final products = snapshot.data!;
                  products.sort((a, b) => a.price.compareTo(b.price));
                  return TabBarView(
                    physics: NeverScrollableScrollPhysics(),
                    children: [
                      ProductsGrid(products: products),
                      ProductsList(products: products),
                    ],
                  );
                }
            }
          },
        ),
      ),
    );
  }
}
