import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class SalesReceiptTile extends StatelessWidget {
  const SalesReceiptTile({super.key, required this.receipt});

  final SalesReceipt receipt;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final date = DateFormat.yMEd(locale).add_Hm().format(receipt.createAt);
    double safeDoubleParse(String? input) {
      if (input == null || input.trim().isEmpty) return 0.0;

      final cleaned = input
          .replaceAll(RegExp(r'[^\d.,-]'), '')
          .replaceAll(',', '.');

      try {
        return double.parse(cleaned);
      } catch (e) {
        debugPrint('Erro ao converter para double: "$input" => $e');
        return 0.0;
      }
    }

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
            '${e.type}: ${currency.format(safeDoubleParse(e.value))}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (receipt.discount != '0' && receipt.discount != '0.0')
          Text(
            'Desconto: ${currency.format(safeDoubleParse(receipt.discount))}',
            overflow: TextOverflow.ellipsis,
          ),
        if (receipt.discountReason.isNotEmpty)
          Text(
            'Razão: ${receipt.discountReason}',
            overflow: TextOverflow.ellipsis,
          ),
        ...receipt.cart.map(
          (e) => BlocSelector<ProductBloc, ProductState, String>(
            selector: (state) {
              return state.products
                      .firstWhere(
                        (product) => product?.id == e.productId,
                        orElse: () => ProductModel.empty(),
                      )
                      ?.name ??
                  e.productId;
            },
            builder: (context, state) {
              return ListTile(
                titleTextStyle: TextStyle(fontSize: 12.0),
                title: Text(
                  '$state x${e.quantity}',
                  overflow: TextOverflow.ellipsis,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
