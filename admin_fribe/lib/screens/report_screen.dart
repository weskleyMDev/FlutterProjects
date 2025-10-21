import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:admin_fribe/widgets/build_report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final weekSalesState = context.watch<WeekSalesBloc>().state;
    final weekSalesBloc = context.read<WeekSalesBloc>();

    return BuildReportView(
      weekSalesState: weekSalesState,
      weekSalesBloc: weekSalesBloc,
      locale: locale,
      currency: currency,
    );
  }
}
