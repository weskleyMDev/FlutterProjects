import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SalesReceiptTile extends StatelessWidget {
  const SalesReceiptTile({super.key, required this.receipt});

  final SalesReceipt receipt;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final date = DateFormat.yMEd(locale).add_Hm().format(receipt.createAt);
    final quantitySum = receipt.cart.fold<Decimal>(
      Decimal.zero,
      (previousValue, element) =>
          previousValue + Decimal.parse(element.quantity.toString()),
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(receipt.id, overflow: TextOverflow.ellipsis)),
            Text(currency.format(double.parse(receipt.total))),
          ],
        ),
        Text(date.capitalize(), overflow: TextOverflow.ellipsis),
        ...receipt.payments.map(
          (e) => Text(
            '${e.type}: ${currency.format(double.parse(e.value))}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (receipt.discount != '0' && receipt.discount != '0.0')
          Text(
            'Desconto: ${currency.format(double.parse(receipt.discount))}',
            overflow: TextOverflow.ellipsis,
          ),
        if (receipt.discountReason.isNotEmpty)
          Text(
            'Razão: ${receipt.discountReason}',
            overflow: TextOverflow.ellipsis,
          ),
        Text('Total de itens: $quantitySum', overflow: TextOverflow.ellipsis),
        ...receipt.cart.map(
          (e) => Text(
            '${e.productId} x${e.quantity}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }
}
