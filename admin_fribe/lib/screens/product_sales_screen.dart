import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/product_sales.dart';
import 'package:admin_fribe/models/week_product_sales.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ProductSalesScreen extends StatelessWidget {
  final String weekId;

  const ProductSalesScreen({super.key, required this.weekId});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final numberFormat = NumberFormat.decimalPatternDigits(
      locale: locale,
      decimalDigits: 3,
    );

    return Scaffold(
      appBar: AppBar(title: Text('Produtos Mais Vendidos')),
      body: BlocBuilder<WeekSalesBloc, WeekSalesState>(
        builder: (context, state) {
          if (state.status == WeekSalesStatus.failure) {
            return Center(child: Text('Erro: ${state.errorMessage}'));
          }

          if (state.status != WeekSalesStatus.success) {
            return const Center(child: CircularProgressIndicator());
          }

          final weekProductSales = state.productsSoldByWeek.firstWhere(
            (w) => w.id == weekId,
            orElse: () => WeekProductSales.empty(),
          );

          final productSalesList = weekProductSales.productSales;
          if (productSalesList.isEmpty) {
            return const Center(
              child: Text('Nenhum produto vendido nessa semana.'),
            );
          }

          final sorted = List<ProductSales>.from(productSalesList)
            ..sort((a, b) => b.totalSales.compareTo(a.totalSales));

          return BlocBuilder<ProductBloc, ProductState>(
            builder: (context, productState) {
              Decimal totalWeekRevenue = Decimal.zero;

              for (final ps in sorted) {
                final product = productState.products.firstWhere(
                  (p) => p?.id == ps.productId,
                  orElse: () => ProductModel.empty(),
                );
                final price = _safeDecimalParse(product?.price);
                totalWeekRevenue += _calculateTotalRevenue(
                  price,
                  ps.totalSales,
                );
              }

              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'SUBTOTAL VENDIDO: ${currency.format(totalWeekRevenue.toDouble())}',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ),

                  const Divider(height: 1),

                  Expanded(
                    child: ListView.builder(
                      itemCount: sorted.length,
                      itemBuilder: (context, index) {
                        final ps = sorted[index];
                        final productId = ps.productId;
                        final quantity = ps.totalSales;

                        return BlocSelector<
                          ProductBloc,
                          ProductState,
                          ProductModel
                        >(
                          selector: (productState) {
                            final prod = productState.products.firstWhere(
                              (p) => p?.id == productId,
                              orElse: () => ProductModel.empty(),
                            );
                            return prod ?? ProductModel.empty();
                          },
                          builder: (context, product) {
                            final Decimal price = _safeDecimalParse(
                              product.price,
                            );
                            final Decimal totalRevenue = _calculateTotalRevenue(
                              price,
                              quantity,
                            );

                            return Card(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              child: ListTile(
                                title: Text(
                                  product.name.isNotEmpty
                                      ? product.name
                                      : productId,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                subtitle: Text(
                                  'Preço: ${currency.format(price.toDouble())}',
                                  maxLines: 1,
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Qtd: ${numberFormat.format(quantity.toDouble())}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      currency.format(totalRevenue.toDouble()),
                                      style: TextStyle(
                                        color: Theme.of(
                                          context,
                                        ).colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }

  Decimal _safeDecimalParse(String? input) {
    if (input == null) return Decimal.zero;
    final cleaned = input.replaceAll(RegExp(r'[^\d.-]'), '');
    return (cleaned.isEmpty || cleaned == '.' || cleaned == '-')
        ? Decimal.zero
        : Decimal.tryParse(cleaned) ?? Decimal.zero;
  }

  Decimal _calculateTotalRevenue(Decimal price, Decimal quantity) {
    return (price * quantity).round(scale: 2);
  }
}
