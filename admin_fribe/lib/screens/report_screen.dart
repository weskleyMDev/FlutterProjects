import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReceiptBloc, SalesReceiptState>(
      builder: (context, state) {
        if (state.salesStatus == SalesReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.salesStatus == SalesReceiptStatus.failure) {
          return Center(
            child: SelectableText('Error: ${state.salesErrorMessage}'),
          );
        } else if (state.salesStatus == SalesReceiptStatus.success) {
          final locale = Localizations.localeOf(context).languageCode;
          final currency = NumberFormat.simpleCurrency(locale: locale);
          final salesReceipts = state.salesReceipts;
          if (salesReceipts.isEmpty) {
            return const Center(child: Text('No sales receipts found.'));
          }
          final totalDiscount = salesReceipts.fold<Decimal>(
            Decimal.zero,
            (previousValue, element) =>
                previousValue + Decimal.parse(element.discount),
          );
          final grandTotal = salesReceipts.fold<Decimal>(
            Decimal.zero,
            (previousValue, element) =>
                previousValue + Decimal.parse(element.total),
          );
          final productCount = salesReceipts
              .expand((e) => e.cart.map((p) => {p.productId: p.quantity}))
              .fold<Map<String, Decimal>>({}, (
                Map<String, Decimal> acc,
                product,
              ) {
                product.forEach((productId, quantity) {
                  acc[productId] =
                      (acc[productId] ?? Decimal.zero) +
                      Decimal.parse(quantity.toString());
                });
                return acc;
              });
          final List<MapEntry<String, Decimal>> sortedProducts =
              productCount.entries.toList()
                ..sort((a, b) => b.value.compareTo(a.value));
          return Center(
            child: ListView(
              shrinkWrap: true,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Total Discount: ${currency.format(totalDiscount.toDouble())}\nTotal Geral: ${currency.format(grandTotal.toDouble())}',
                  ),
                ),
                const SizedBox(height: 20),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: sortedProducts.length,
                  itemBuilder: (context, index) {
                    final productEntry = sortedProducts[index];
                    return ListTile(
                      title: BlocSelector<ProductBloc, ProductState, String>(
                        selector: (productState) {
                          return productState.products
                                  .firstWhere(
                                    (product) =>
                                        product?.id == productEntry.key,
                                    orElse: () => ProductModel.empty(),
                                  )
                                  ?.name ??
                              '';
                        },
                        builder: (context, productName) {
                          return Text(productName);
                        },
                      ),
                      subtitle: Text('Sold: ${productEntry.value}'),
                    );
                  },
                ),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const CircularProgressIndicator(),
                Text('Please wait...'),
              ],
            ),
          );
        }
      },
    );
  }
}
