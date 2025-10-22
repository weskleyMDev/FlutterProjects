import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:admin_fribe/widgets/report_tile.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
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
        if (sales.isEmpty) {
          return Center(
            child: Text(
              'No sales data available for the selected month.',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
            ),
          );
        }
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DropdownButton<DateTime>(
                  value: weekSalesState.selectedMonth,
                  isExpanded: true,
                  icon: const Icon(FontAwesome.calendar),
                  iconEnabledColor: Colors.orange.shade700,
                  items: weekSalesState.allMonths.map((date) {
                    final label = DateFormat.yMMMM(locale).format(date);
                    return DropdownMenuItem(
                      value: date,
                      child: Text(label.capitalize()),
                    );
                  }).toList(),
                  onChanged: (newDate) {
                    if (newDate != null) {
                      weekSalesBloc.add(
                        WeekSalesRequested(locale: locale, month: newDate),
                      );
                    }
                  },
                ),
              ),
              const SizedBox(height: 8),
              ...sales.map(
                (week) =>
                    ReportTile(title: week.id, week: week, currency: currency),
              ),
            ],
          ),
        );
      case WeekSalesStatus.failure:
        return Center(child: Text('Error: ${weekSalesState.errorMessage}'));
    }
  }
}
