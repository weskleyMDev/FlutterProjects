import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:admin_fribe/widgets/products_receipt_tile.dart';
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
            '${e.type.capitalize()}: ${currency.format(safeDoubleParse(e.value))}',
            overflow: TextOverflow.ellipsis,
          ),
        ),
        if (receipt.discount != '0' &&
            receipt.discount != '0.0' &&
            receipt.discount.isNotEmpty)
          Text(
            'Desconto: ${currency.format(safeDoubleParse(receipt.discount))}',
            overflow: TextOverflow.ellipsis,
          ),
        if (receipt.discountReason.isNotEmpty)
          Text(
            'Razão: ${receipt.discountReason.capitalize()}',
            overflow: TextOverflow.ellipsis,
          ),
        if (receipt.shipping.isNotEmpty &&
            receipt.shipping != '0' &&
            receipt.shipping != '0.0')
          Text(
            'Frete: ${currency.format(safeDoubleParse(receipt.shipping))}',
            overflow: TextOverflow.ellipsis,
          ),
        if (receipt.tariffs.isNotEmpty &&
            receipt.tariffs != '0' &&
            receipt.tariffs != '0.0')
          Text(
            'Taxas: ${currency.format(safeDoubleParse(receipt.tariffs))}',
            overflow: TextOverflow.ellipsis,
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: receipt.cart
                .map(
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
                    builder: (context, productName) {
                      return ProductsReceiptTile(
                        productName: productName,
                        quantity: e.quantity,
                        subtotal: currency.format(e.subtotal),
                      );
                    },
                  ),
                )
                .toList(),
          ),
        ),
      ],
    );
  }
}
