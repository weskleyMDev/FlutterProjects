import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:seller_fribe/blocs/products/product_bloc.dart';
import 'package:seller_fribe/models/product_model.dart';
import 'package:seller_fribe/models/receipt_model.dart';
import 'package:seller_fribe/utils/capitalize_text.dart';

class ReceiptTile extends StatelessWidget {
  const ReceiptTile({
    super.key,
    required this.currency,
    required this.receipt,
    required this.locale,
  });

  final NumberFormat currency;
  final ReceiptModel receipt;
  final String locale;

  @override
  Widget build(BuildContext context) {
    String changeCurrency(String value) => currency.format(double.parse(value));
    return Card(
      color: Theme.of(context).colorScheme.surface,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 4.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SelectableText(
                  receipt.id,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  currency.format(double.parse(receipt.total).toDouble()),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              DateFormat.yMEd(locale)
                  .add_Hm()
                  .format(receipt.createAt ?? DateTime.now())
                  .capitalize(),
            ),
            if (receipt.discount.isNotEmpty)
              Text('Desconto: ${changeCurrency(receipt.discount)}'),
            if (receipt.shipping.isNotEmpty)
              Text('Frete: ${changeCurrency(receipt.shipping)}'),
            if (receipt.tariffs.isNotEmpty)
              Text('Taxas: ${changeCurrency(receipt.tariffs)}'),
            ...receipt.payments.map(
              (payment) => Text(
                '${payment.type.capitalize()}: ${changeCurrency(payment.value)}',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            ...receipt.cart.map(
              (item) => BlocSelector<ProductBloc, ProductState, ProductModel>(
                selector: (state) {
                  return state.allProducts.firstWhere(
                    (product) => product.id == item.productId,
                  );
                },
                builder: (context, product) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('   ${product.name.capitalize()} x${item.quantity}'),
                      Text(currency.format(item.subtotal)),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
