import 'package:admin_shop/blocs/products/product_bloc.dart';
import 'package:admin_shop/generated/l10n.dart';
import 'package:admin_shop/screens/loading_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:transparent_image/transparent_image.dart';

enum Category { tshirts, pants, jackets, shorts }

class ProductsTab extends StatelessWidget {
  const ProductsTab({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.compactSimpleCurrency(locale: locale);
    final categories = Category.values;
    String getCategoryLabel(Category category, BuildContext context) =>
        switch (category) {
          Category.tshirts => S.of(context).shirt(2),

          Category.pants => S.of(context).pants(2),

          Category.jackets => S.of(context).jacket(2),

          Category.shorts => S.of(context).shorts(2),
        };
    Widget showCategories(BuildContext context, int index) {
      return Card(
        child: ExpansionTile(
          leading: CircleAvatar(
            child: SvgPicture.asset(
              'assets/images/${categories[index].name}.svg',
            ),
          ),
          title: Text(getCategoryLabel(categories[index], context)),
          children: [
            BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                final products =
                    state.productsByCategory[categories[index].name] ?? [];
                if (products.isEmpty) {
                  return Center(child: const Text('No data found!'));
                }
                return Stack(
                  children: [
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: products.length,
                      itemBuilder: (context, productIndex) {
                        final product = products[productIndex];
                        return ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: FadeInImage.memoryNetwork(
                              placeholder: kTransparentImage,
                              image: product.images.first,
                              width: 40,
                              height: 40,
                              fit: BoxFit.cover,
                            ),
                          ),
                          title: Text(product.title[locale] ?? 'Unknown'),
                          trailing: Text(
                            currency.format(product.price),
                            style: TextStyle(fontSize: 14.0),
                          ),
                        );
                      },
                    ),
                    if (state.statusByCategory[categories[index].name] ==
                        ProductStateStatus.waiting)
                      const LoadingScreen(),
                  ],
                );
              },
            ),
          ],
        ),
      );
    }

    return ListView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        ...List.generate(categories.length, (i) => showCategories(context, i)),
      ],
    );
  }
}
