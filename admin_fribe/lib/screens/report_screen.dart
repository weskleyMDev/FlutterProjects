import 'package:admin_fribe/blocs/sales_receipt/sales_receipt_bloc.dart';
import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/widgets/report_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final weekSalesBloc = BlocProvider.of<WeekSalesBloc>(context);
    return BlocListener<SalesReceiptBloc, SalesReceiptState>(
      listener: (context, receiptState) {
        if (receiptState.salesStatus == SalesReceiptStatus.success) {
          weekSalesBloc.add(
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

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: DropdownButton<String>(
                      value: state.selectedMonth,
                      isExpanded: true,
                      icon: const Icon(FontAwesome.calendar),
                      iconEnabledColor: Colors.orange.shade700,
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
                          weekSalesBloc.add(
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
                    return ReportTile(
                      title: week.id,
                      week: week,
                      currency: currency,
                    );
                  }),
                ],
              ),
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
