import 'package:admin_fribe/blocs/week_sales/week_sales_bloc.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ReportTile extends StatelessWidget {
  const ReportTile({
    super.key,
    required this.title,
    required this.state,
    required this.currency,
  });

  final String title;
  final WeekSalesState state;
  final NumberFormat currency;

  @override
  Widget build(BuildContext context) {
    Widget weekResume(
      NumberFormat currency,
      Decimal totalMethod,
      String method,
      Color color,
      IconData icon,
      BuildContext context,
    ) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 12),
            Expanded(child: Text(method)),
            Text(
              currency.format(totalMethod.toDouble()),
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      );
    }

    return Card(
      child: ExpansionTile(
        title: Text(title),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Total da Semana:'),
            Text(
              currency.format(state.totalWeekSales.toDouble()).toString(),
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
          weekResume(
            currency,
            state.totalWeekSalesCash,
            'Dinheiro',
            Colors.green,
            FontAwesome5.money_bill,
            context,
          ),
          weekResume(
            currency,
            state.totalWeekSalesCredit,
            'Crédito',
            Colors.amber,
            FontAwesome5.credit_card,
            context,
          ),
          weekResume(
            currency,
            state.totalWeekSalesDebit,
            'Débito',
            Colors.blue,
            FontAwesome5.credit_card,
            context,
          ),
          weekResume(
            currency,
            state.totalWeekSalesPix,
            'Pix',
            Colors.purple,
            FontAwesome5.qrcode,
            context,
          ),
          const Divider(),
          weekResume(
            currency,
            state.totalDiscounts,
            'Descontos',
            Colors.red.shade700,
            FontAwesome5.minus_circle,
            context,
          ),
          weekResume(
            currency,
            state.totalShipping,
            'Frete',
            Colors.blueGrey,
            FontAwesome5.shipping_fast,
            context,
          ),
          weekResume(
            currency,
            state.totalTariffs,
            'Taxas',
            Colors.teal,
            FontAwesome5.university,
            context,
          ),
        ],
      ),
    );
  }
}
