import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:shop_v2/l10n/app_localizations.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductDetails extends StatelessWidget {
  const ProductDetails({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final maxHeigh = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: Text(product.title[locale] ?? 'Error')),
      body: ListView(
        children: [
          CarouselSlider.builder(
            itemCount: product.images.length,
            itemBuilder: (context, index, _) {
              return FadeInImage.memoryNetwork(
                placeholder: kTransparentImage,
                image: product.images[index],
                fit: BoxFit.cover,
                width: maxWidth,
                height: maxHeigh * 0.4,
              );
            },
            options: CarouselOptions(
              height: maxHeigh * 0.4,
              viewportFraction: 0.9,
              enableInfiniteScroll: true,
              enlargeCenterPage: false,
              autoPlay: true,
              autoPlayInterval: Duration(seconds: 5),
            ),
          ),
          Text(product.title[locale] ?? 'Error'),
          Text(
            'R\$ ${product.price}',
            style: TextStyle(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
          ),
          Text(AppLocalizations.of(context)!.size),
          SizedBox(
            height: maxHeigh * 0.05,
            child: ListView.builder(
              itemCount: product.sizes.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Chip(label: Text(product.sizes[index]));
              },
            ),
          ),
        ],
      ),
    );
  }
}
