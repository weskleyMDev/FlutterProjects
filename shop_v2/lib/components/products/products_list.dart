import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;
    final maxHeigh = MediaQuery.of(context).size.height;
    final maxWidth = MediaQuery.of(context).size.width;
    return ListView.builder(
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final locale = Localizations.localeOf(context).languageCode;
        return InkWell(
          onTap: () => context.goNamed('product-details', extra: product.id),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Flexible(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.images.first,
                        fit: BoxFit.cover,
                        height: isPortrait ? maxHeigh * 0.25 : maxHeigh * 0.4,
                        width: isPortrait ? maxWidth * 0.35 : maxWidth * 0.3,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          product.title[locale] ?? 'Error',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
