import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();

    return BlocListener<SalesReceiptBloc, SalesReceiptState>(
      listener: (context, receiptState) {
        if (receiptState.salesStatus == SalesReceiptStatus.success) {
          context.read<WeekSalesBloc>().add(
            WeekSalesRequested(
              receipts: receiptState.salesReceipts,
              locale: locale,
              month: '',
            ),
          );
        }
      },
      child: BlocBuilder<WeekSalesBloc, WeekSalesState>(
        builder: (context, state) {
          if (state.status == WeekSalesStatus.failure) {
            return Center(child: Text('Erro: ${state.errorMessage}'));
          } else if (state.status == WeekSalesStatus.success) {
            if (state.weekSales.isEmpty) {
              return const Center(child: Text('Nenhuma venda encontrada.'));
            }

            final currency = NumberFormat.simpleCurrency(locale: locale);

            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: DropdownButton<String>(
                    value: state.selectedMonth,
                    isExpanded: true,
                    items: state.allMonths
                        .map(
                          (month) => DropdownMenuItem(
                            value: month,
                            child: Text(month),
                          ),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        context.read<WeekSalesBloc>().add(
                          WeekSalesRequested(
                            receipts: state.originalReceipts,
                            locale: locale,
                            month: value,
                          ),
                        );
                      }
                    },
                  ),
                ),
                ...state.weekSales.map((week) {
                  final total = week.salesReceipts.fold<Decimal>(
                    Decimal.zero,
                    (prev, receipt) => prev + Decimal.parse(receipt.total),
                  );

                  return Card(
                    child: ListTile(
                      title: Text(
                        week.id,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Total: ${currency.format(total.toDouble())}',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      onTap: () =>
                          context.pushNamed('product-sales', extra: week.id),
                    ),
                  );
                }),
              ],
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
