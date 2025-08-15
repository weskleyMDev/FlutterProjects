import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shop_v2/models/products/product_model.dart';
import 'package:transparent_image/transparent_image.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key, required this.products});

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 300.0,
        childAspectRatio: 1.0,
        crossAxisSpacing: 1.0,
      ),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        final locale = Localizations.localeOf(context).languageCode;
        return InkWell(
          onTap: () => context.goNamed('product-details', extra: product.id),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12.0),
                      child: FadeInImage.memoryNetwork(
                        placeholder: kTransparentImage,
                        image: product.images.first,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Text(
                    product.title[locale] ?? 'Error',
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2).replaceAll('.', ',')}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
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
