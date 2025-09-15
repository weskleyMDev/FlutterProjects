import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/widgets/sales_receipt_tile.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReceiptsScreen extends StatelessWidget {
  const ReceiptsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SalesReceiptBloc, SalesReceiptState>(
      builder: (context, state) {
        if (state.salesStatus == SalesReceiptStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.salesStatus == SalesReceiptStatus.failure) {
          return Center(child: Text('Error: ${state.salesErrorMessage}'));
        } else if (state.salesStatus == SalesReceiptStatus.success) {
          final salesReceipts = state.salesReceipts;
          if (salesReceipts.isEmpty) {
            return const Center(child: Text('No sales receipts found.'));
          }

          final grouped = groupBy(
            salesReceipts,
            (r) => DateFormat('yyyy-MM-dd').format(r.createAt),
          );
          final dateKeys = grouped.keys.toList()
            ..sort((a, b) => b.compareTo(a));

          final items = <Widget>[];
          for (final date in dateKeys) {
            final receiptsOfDay = grouped[date]!;
            final totalOfDay = receiptsOfDay
                .fold<Decimal>(
                  Decimal.zero,
                  (previousValue, element) =>
                      previousValue + Decimal.parse(element.total),
                )
                .round(scale: 2);
            items.add(
              ExpansionTile(
                title: Text(
                  '${DateFormat('dd/MM/yyyy').format(DateTime.parse(date))} - Total: ${NumberFormat.simpleCurrency(locale: Localizations.localeOf(context).languageCode).format(totalOfDay.toDouble())}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                children: receiptsOfDay
                    .map(
                      (receipt) => Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SalesReceiptTile(receipt: receipt),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }

          return ListView(children: items);
        }
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Text('Please wait...'),
            ],
          ),
        );
      },
    );
  }
}
