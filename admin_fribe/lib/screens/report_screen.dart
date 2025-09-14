import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
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
          return Column(
            children: [
              Center(
                child: Text(
                  'Total Discount: ${currency.format(totalDiscount.toDouble())}\nTotal Geral: ${currency.format(grandTotal.toDouble())}',
                ),
              ),
            ],
          );
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
