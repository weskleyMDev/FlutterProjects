import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  String? selectedMonth;

  String weekKey(DateTime date) {
    final startDay = DateTime(2025, 10, 1);
    final daysSinceStart = date.difference(startDay).inDays;
    final weekIndex = (daysSinceStart / 7).floor();
    final weekStart = startDay.add(Duration(days: weekIndex * 7));
    final weekEnd = weekStart.add(const Duration(days: 6));
    return '${DateFormat('dd/MM/yyyy').format(weekStart)} até ${DateFormat('dd/MM/yyyy').format(weekEnd)}';
  }

  String mothKey(DateTime date) {
    return DateFormat.yMMMM(
      Localizations.localeOf(context).languageCode,
    ).format(date).capitalize();
  }

  Decimal safeDecimalParse(String? input) {
    if (input == null || input.trim().isEmpty) return Decimal.zero;

    final cleaned = input.replaceAll(RegExp(r'[^\d.-]'), '');

    if (cleaned.isEmpty || cleaned == '.' || cleaned == '-') {
      return Decimal.zero;
    }

    try {
      return Decimal.parse(cleaned);
    } catch (e) {
      return Decimal.zero;
    }
  }

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
          final numberFormat = NumberFormat.decimalPatternDigits(
            locale: locale,
            decimalDigits: 3,
          );
          final startDate = DateTime(2025, 10, 1);
          final salesReceipts = state.salesReceipts;
          if (salesReceipts.isEmpty) {
            return const Center(child: Text('No sales receipts found.'));
          }
          final allMonthsSet = <String>{};
          final mapMothToDate = <String, DateTime>{};
          for (final receipt in salesReceipts) {
            if (receipt.createAt.isBefore(startDate)) {
              continue;
            }
            final mKey = mothKey(receipt.createAt);
            allMonthsSet.add(mKey);
            mapMothToDate[mKey] = DateTime(
              receipt.createAt.year,
              receipt.createAt.month,
            );
          }
          final allMonths = allMonthsSet.toList()
            ..sort((a, b) => mapMothToDate[b]!.compareTo(mapMothToDate[a]!));
          selectedMonth ??= allMonths.isNotEmpty ? allMonths.first : null;
          final filteredReceipts = salesReceipts.where((receipt) {
            if (receipt.createAt.isBefore(startDate)) {
              return false;
            }
            final mKey = mothKey(receipt.createAt);
            return mKey == selectedMonth;
          }).toList();
          final grouped = <String, List<SalesReceipt>>{};

          for (final receipt in filteredReceipts) {
            if (receipt.createAt.isBefore(startDate)) continue;

            final key = weekKey(receipt.createAt);
            grouped.putIfAbsent(key, () => []).add(receipt);
          }
          final weekKeys = grouped.keys.toList()
            ..sort(
              (a, b) => DateFormat(
                'dd/MM/yyyy',
              ).parse(b).compareTo(DateFormat('dd/MM/yyyy').parse(a)),
            );
          final productsSoldByWeek = <String, Map<String, Decimal>>{};
          for (final entry in grouped.entries) {
            final week = entry.key;
            final receipts = entry.value;
            final productTotals = <String, Decimal>{};
            for (final receipt in receipts) {
              for (final item in receipt.cart) {
                final productId = item.productId;
                final quantity = safeDecimalParse(item.quantity.toString());
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
                      previousValue + safeDecimalParse(element.total),
                )
                .round(scale: 2);
            final discountOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + safeDecimalParse(element.discount),
                )
                .round(scale: 2);
            final shippingOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + safeDecimalParse(element.shipping),
                )
                .round(scale: 2);
            final tariffsOfWeek = receiptsOfWeek
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + safeDecimalParse(element.tariffs),
                )
                .round(scale: 2);
            final totalCashOfWeek = receiptsOfWeek
                .fold<Decimal>(Decimal.zero, (total, receipt) {
                  final payments = receipt.payments;
                  final cashPayments = payments.where(
                    (p) => p.type == 'dinheiro',
                  );

                  final cashSum = cashPayments.fold<Decimal>(Decimal.zero, (
                    subtotal,
                    payment,
                  ) {
                    final value = safeDecimalParse(
                      (payment.value).replaceAll(',', '.'),
                    );
                    return subtotal + value;
                  });

                  return total + cashSum;
                })
                .round(scale: 2);
            final totalCreditOfWeek = receiptsOfWeek.fold<Decimal>(
              Decimal.zero,
              (total, receipt) {
                final payments = receipt.payments;
                final creditPayments = payments.where(
                  (p) => p.type == 'credito',
                );

                final creditSum = creditPayments.fold<Decimal>(Decimal.zero, (
                  subtotal,
                  payment,
                ) {
                  final value = safeDecimalParse(
                    (payment.value).replaceAll(',', '.'),
                  );
                  return subtotal + value;
                });

                return total + creditSum;
              },
            );
            final totalDebitOfWeek = receiptsOfWeek.fold<Decimal>(
              Decimal.zero,
              (total, receipt) {
                final payments = receipt.payments;
                final debitPayments = payments.where((p) => p.type == 'debito');

                final debitSum = debitPayments.fold<Decimal>(Decimal.zero, (
                  subtotal,
                  payment,
                ) {
                  final value = safeDecimalParse(
                    (payment.value).replaceAll(',', '.'),
                  );
                  return subtotal + value;
                });

                return total + debitSum;
              },
            );
            final totalPixOfWeek = receiptsOfWeek.fold<Decimal>(Decimal.zero, (
              total,
              receipt,
            ) {
              final payments = receipt.payments;
              final pixPayments = payments.where((p) => p.type == 'pix');

              final pixSum = pixPayments.fold<Decimal>(Decimal.zero, (
                subtotal,
                payment,
              ) {
                final value = safeDecimalParse(
                  (payment.value).replaceAll(',', '.'),
                );
                return subtotal + value;
              });

              return total + pixSum;
            });
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
                  'Total da Semana: ${currency.format(totalOfWeek.toDouble())}\nDinheiro: ${currency.format(totalCashOfWeek.toDouble())}\nCrédito: ${currency.format(totalCreditOfWeek.toDouble())}\nDébito: ${currency.format(totalDebitOfWeek.toDouble())}\nPIX: ${currency.format(totalPixOfWeek.toDouble())}\nDescontos: ${currency.format(discountOfWeek.toDouble())}\nFrete: ${currency.format(shippingOfWeek.toDouble())}\nTaxas: ${currency.format(tariffsOfWeek.toDouble())}',
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
                          final Decimal price = safeDecimalParse(p.price);
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
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: selectedMonth,
                  hint: const Text('Select Month'),
                  items: allMonths.map((month) {
                    return DropdownMenuItem(value: month, child: Text(month));
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMonth = value;
                    });
                  },
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
