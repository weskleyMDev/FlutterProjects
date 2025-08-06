import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:shop_v2/components/home/home_drawer.dart';
import 'package:transparent_image/transparent_image.dart';

import '../../l10n/app_localizations.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  Widget _categoryCard(BuildContext context, String imageUrl, String title) =>
      Card(
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
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/7223/7223124.png',
            AppLocalizations.of(context)!.jacket(2),
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/8622/8622723.png',
            AppLocalizations.of(context)!.shorts(2),
          ),
          _categoryCard(
            context,
            'https://cdn-icons-png.flaticon.com/128/2122/2122483.png',
            AppLocalizations.of(context)!.pants(2),
          ),
        ],
      ),
    );
  }
}
