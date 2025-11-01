import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:admin_fribe/widgets/report_tile.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class BuildReportView extends StatelessWidget {
  const BuildReportView({
    super.key,
    required this.weekSalesState,
    required this.weekSalesBloc,
    required this.locale,
    required this.currency,
  });

  final WeekSalesState weekSalesState;
  final WeekSalesBloc weekSalesBloc;
  final String locale;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    switch (weekSalesState.status) {
      case WeekSalesStatus.initial:
      case WeekSalesStatus.inProgress:
        return Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const CircularProgressIndicator(),
              Text('Please wait...'),
            ],
          ),
        );
      case WeekSalesStatus.success:
        final sales = weekSalesState.weekSales;
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                children: [
                  Expanded(
                    child: DropdownButton<int>(
                      value: weekSalesState.selectedYear,
                      isExpanded: true,
                      items: weekSalesState.allYears.map((year) {
                        return DropdownMenuItem(
                          value: year,
                          child: Text(year.toString()),
                        );
                      }).toList(),
                      onChanged: (newYear) {
                        if (newYear != null) {
                          weekSalesBloc.add(
                            WeekSalesRequested(
                              locale: locale,
                              year: newYear,
                              month: weekSalesState.selectedMonth,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: DropdownButton<int>(
                      value: weekSalesState.selectedMonth,
                      isExpanded: true,
                      items: List.generate(12, (i) => i + 1).map((month) {
                        final label = DateFormat.MMMM(
                          locale,
                        ).format(DateTime(0, month));
                        return DropdownMenuItem(
                          value: month,
                          child: Text(label.capitalize()),
                        );
                      }).toList(),
                      onChanged: (newMonth) {
                        if (newMonth != null) {
                          weekSalesBloc.add(
                            WeekSalesRequested(
                              locale: locale,
                              year: weekSalesState.selectedYear,
                              month: newMonth,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Chip(
                label: Text.rich(
                  TextSpan(
                    text: 'Net Monthly Total: ',
                    children: [
                      TextSpan(
                        text: currency.format(
                          weekSalesState.netMonthlyTotal.toDouble(),
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: sales.isEmpty
                    ? Center(
                        child: Text(
                          'No sales data available for the selected month.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: sales.length,
                        itemBuilder: (context, index) {
                          final week = sales[index];
                          return ReportTile(
                            title: week.id,
                            week: week,
                            currency: currency,
                          );
                        },
                      ),
              ),
            ],
          ),
        );
      case WeekSalesStatus.failure:
        return Center(child: Text('Error: ${weekSalesState.errorMessage}'));
    }
  }
}
