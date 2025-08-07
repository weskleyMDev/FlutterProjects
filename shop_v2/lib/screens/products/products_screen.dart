import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/stores/products/products.store.dart';

final productsStore = GetIt.instance<ProductsStore>();

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(productsStore.categoryLabel ?? 'Error')),
      body: StreamBuilder(
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
                final tshirts = snapshot.data!;
                return ListView.builder(
                  itemCount: tshirts.length,
                  itemBuilder: (context, index) {
                    final tshirt = tshirts[index];
                    final locale = Localizations.localeOf(context).languageCode;
                    return ListTile(
                      title: Text(tshirt.title[locale] ?? 'Error'),
                    );
                  },
                );
              }
          }
        },
      ),
    );
  }
}
