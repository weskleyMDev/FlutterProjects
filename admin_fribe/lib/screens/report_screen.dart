import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String weekKey(DateTime date) {
      final monday = date.subtract(Duration(days: date.weekday - 1));
      final sunday = monday.add(Duration(days: 6));
      return '${DateFormat('dd/MM/yyyy').format(monday)} até ${DateFormat('dd/MM/yyyy').format(sunday)}';
    }

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
          final numberFormat = NumberFormat.decimalPatternDigits(
            locale: locale,
            decimalDigits: 3,
          );
          final salesReceipts = state.salesReceipts;
          if (salesReceipts.isEmpty) {
            return const Center(child: Text('No sales receipts found.'));
          }
          final grouped = <String, List<SalesReceipt>>{};
          for (final receipt in salesReceipts) {
            final key = weekKey(receipt.createAt);
            grouped.putIfAbsent(key, () => []).add(receipt);
          }
          final weekKeys = grouped.keys.toList()
            ..sort((a, b) => b.compareTo(a));
          final productsSoldByWeek = <String, Map<String, Decimal>>{};
          for (final entry in grouped.entries) {
            final week = entry.key;
            final receipts = entry.value;
            final productTotals = <String, Decimal>{};
            for (final receipt in receipts) {
              for (final item in receipt.cart) {
                final productId = item.productId;
                final quantity = Decimal.parse(item.quantity.toString());
                productTotals[productId] =
                    (productTotals[productId] ?? Decimal.zero) + quantity;
              }
            }
            productsSoldByWeek[week] = productTotals;
          }
          final items = <Widget>[];
          for (final week in weekKeys) {
            final productsSold = productsSoldByWeek[week]!;
            final sortedProducts = productsSold.entries.toList()
              ..sort((a, b) => b.value.compareTo(a.value));
            final receiptsOfWeek = grouped[week]!;
            final totalOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + Decimal.parse(element.total),
                )
                .round(scale: 2);
            final discountOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + Decimal.parse(element.discount),
                )
                .round(scale: 2);
            final shippingOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + Decimal.parse(element.shipping),
                )
                .round(scale: 2);

            final totalCashOfWeek = receiptsOfWeek
                .where(
                  (receipt) => receipt.payments.any(
                    (payment) => payment.type == 'Dinheiro',
                  ),
                )
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + Decimal.parse(element.total),
                )
                .round(scale: 2);
            items.add(
              ExpansionTile(
                title: Text(
                  week,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Text(
                  'Total da Semana: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(totalOfWeek.toDouble())}\nDinheiro: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(totalCashOfWeek.toDouble())}\nDescontos: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(discountOfWeek.toDouble())}\nFrete: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(shippingOfWeek.toDouble())}',
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                children: sortedProducts
                    .map(
                      (
                        productEntry,
                      ) => BlocSelector<ProductBloc, ProductState, ProductModel>(
                        selector: (productState) {
                          final product = productState.products.firstWhere(
                            (product) => product?.id == productEntry.key,
                            orElse: () => ProductModel.empty(),
                          );

                          return product ?? ProductModel.empty();
                        },
                        builder: (context, p) {
                          final Decimal price = Decimal.parse(p.price);
                          return Card(
                            child: ListTile(
                              titleTextStyle: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              title: Text(
                                '${p.name} - ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(price.toDouble())}',
                              ),
                              subtitle: Text(
                                'Sold: ${numberFormat.format(productEntry.value.toDouble())}(${p.measure})',
                              ),
                            ),
                          );
                        },
                      ),
                    )
                    .toList(),
              ),
            );
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                child: Text(
                  'Total Discount: ${currency.format(state.totalDiscount.toDouble())}\nTotal Shipping: ${currency.format(state.totalShipping.toDouble())}\nTotal Sales: ${currency.format(state.totalSales.toDouble())}\nTotal Credit Card: ${currency.format(state.totalCredit.toDouble())}\nTotal Debit Card: ${currency.format(state.totalDebit.toDouble())}\nTotal Cash: ${currency.format(state.totalCash.toDouble())}\nTotal PIX: ${currency.format(state.totalPix.toDouble())}',
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ...items,
            ],
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
