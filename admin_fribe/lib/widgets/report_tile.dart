import 'package:admin_fribe/models/report_data_model.dart';
import 'package:admin_fribe/models/week_sales.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.title,
    required this.week,
    required this.currency,
  });

  final String title;
  final WeekSales week;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    Widget weekResume(ReportDataModel data) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(data.icon, color: data.color),
            const SizedBox(width: 12),
            Expanded(child: Text(data.title)),
            Text(
              currency.format(data.total.toDouble()),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    ReportDataModel data(
      String title,
      Decimal total,
      Color color,
      IconData icon,
    ) {
      return ReportDataModel.empty().copyWith(
        title: title,
        total: total,
        color: color,
        icon: icon,
      );
    }

    final List<ReportDataModel> payments = [
      data(
        'Dinheiro',
        week.totalCash,
        Colors.green,
        FontAwesome5.money_bill_alt,
      ),
      data('Crédito', week.totalCredit, Colors.blue, FontAwesome5.credit_card),
      data('Débito', week.totalDebit, Colors.purple, FontAwesome5.university),
      data('Pix', week.totalPix, Colors.white70, FontAwesome5.qrcode),
    ];

    final sortedData = List<ReportDataModel>.from(payments)
      ..sort((a, b) => b.total.compareTo(a.total));

    final List<ReportDataModel> adjustments = [
      data(
        'Descontos',
        week.totalDiscounts,
        Colors.red,
        FontAwesome5.minus_circle,
      ),
      data(
        'Frete',
        week.totalShipping,
        Colors.teal,
        FontAwesome5.shipping_fast,
      ),
      data('Taxas', week.totalTariffs, Colors.orange, FontAwesome5.coins),
    ];

    return Card(
      child: ExpansionTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total da Semana:'),
            Text(
              currency.format(week.totalSales.toDouble()).toString(),
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.lightGreen,
              ),
            ),
          ],
        ),
        trailing: IconButton(
          onPressed: () => context.pushNamed('product-sales', extra: title),
          icon: const Icon(FontAwesome5.clipboard_list, color: Colors.white70),
          tooltip: 'Produtos vendidos na semana',
        ),
        childrenPadding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
        children: [
          ...sortedData.map((data) => weekResume(data)),
          const Divider(),
          ...adjustments.map((data) => weekResume(data)),
        ],
      ),
    );
  }
}
