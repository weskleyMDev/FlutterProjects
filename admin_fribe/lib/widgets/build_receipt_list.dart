import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/widgets/receipt_pdf_dialog.dart';
import 'package:admin_fribe/widgets/sales_receipt_tile.dart';
import 'package:collection/collection.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildReceiptList extends StatelessWidget {
  const BuildReceiptList({super.key, required this.receiptState});

  final SalesReceiptState receiptState;

  @override
  Widget build(BuildContext context) {
    Future<bool?> showPdfDialog(SalesReceipt receipt) async {
      return await showDialog<bool>(
        context: context,
        builder: (context) => ReceiptPdfDialog(receipt: receipt),
      );
    }

    switch (receiptState.salesStatus) {
      case SalesReceiptStatus.initial:
        return const Center(
          child: Text('Selecione as datas para carregar os recibos!'),
        );
      case SalesReceiptStatus.loading:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Text('Please wait...'),
            ],
          ),
        );
      case SalesReceiptStatus.success:
        final salesReceipts = receiptState.salesReceipts;
        if (salesReceipts.isEmpty) {
          return const Center(child: Text('No sales receipts found.'));
        }
        final grouped = groupBy(
          salesReceipts,
          (r) => DateFormat('yyyy-MM-dd').format(r.createAt),
        );
        final dateKeys = grouped.keys.toList()..sort((a, b) => b.compareTo(a));

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
                    (receipt) => InkWell(
                      onTap: () async {
                        final result = await showPdfDialog(receipt);
                        if (result == true) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context)
                            ..clearSnackBars()
                            ..showSnackBar(
                              const SnackBar(
                                content: Text('Recibo salvo em PDF!'),
                              ),
                            );
                        }
                      },
                      child: Card(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SalesReceiptTile(receipt: receipt),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
          );
        }
        return ListView(children: items);
      case SalesReceiptStatus.failure:
        return Center(
          child: Text(
            'Error: ${receiptState.salesErrorMessage}',
            style: const TextStyle(color: Colors.red),
          ),
        );
    }
  }
}
