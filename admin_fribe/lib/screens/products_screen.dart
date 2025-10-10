import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/widgets/product_detail_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final currencyFormat = NumberFormat.simpleCurrency(locale: locale);
    final numberFormat = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 3,
    );
    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        if (state.status == ProductStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.status == ProductStatus.success) {
          final products = state.products;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = products[index] ?? ProductModel.empty();
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                      width: 1.0,
                    ),
                  ),
                  child: ProductDetailTile(
                    product: product,
                    currencyFormat: currencyFormat,
                    numberFormat: numberFormat,
                  ),
                ),
              );
            },
          );
        } else if (state.status == ProductStatus.failure) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else {
          return const Center(child: Text('No products available.'));
        }
      },
    );
  }
}
