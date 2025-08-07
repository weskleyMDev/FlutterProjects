import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:shop_v2/stores/products/products.store.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../l10n/app_localizations.dart';

final productStore = GetIt.instance<ProductsStore>();

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key});

  Widget _categoryCard(
    BuildContext context,
    String imageUrl,
    String title,
    CategoriesList category,
  ) => Card(
    margin: const EdgeInsets.only(left: 10.0, right: 10.0, bottom: 10.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: ClipOval(
          child: FadeInImage.memoryNetwork(
            placeholder: kTransparentImage,
            image: imageUrl,
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          ),
        ),
        title: Text(title),
        trailing: Icon(FontAwesome.forward),
        onTap: () async {
          await productStore.toggleCategory(context, category);
          if (!context.mounted) return;
          context.goNamed('products-screen');
        },
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.product(2)),
      ),
      drawer: HomeDrawer(),
      body: ListView(
        children: [
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/4715/4715310.png',
            AppLocalizations.of(context)!.tshirt(2),
            CategoriesList.tshirts,
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/7223/7223124.png',
            AppLocalizations.of(context)!.jacket(2),
            CategoriesList.jackets,
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/8622/8622723.png',
            AppLocalizations.of(context)!.shorts(2),
            CategoriesList.shorts,
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/2122/2122483.png',
            AppLocalizations.of(context)!.pants(2),
            CategoriesList.pants,
          ),
        ],
      ),
    );
  }
}
