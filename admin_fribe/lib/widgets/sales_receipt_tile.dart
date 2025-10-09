import 'package:admin_fribe/blocs/product/product_bloc.dart';
import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/models/sales_receipt_model.dart';
import 'package:admin_fribe/utils/capitalize_text.dart';
import 'package:admin_fribe/widgets/products_receipt_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:intl/intl.dart';

class SalesReceiptTile extends StatelessWidget {
  const SalesReceiptTile({super.key, required this.receipt});

  final SalesReceipt receipt;
  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).languageCode;
    final currency = NumberFormat.simpleCurrency(locale: locale);
    final date = DateFormat.yMEd(locale).add_Hm().format(receipt.createAt);
    final Map<String, IconData> iconMap = {
      'dinheiro': FontAwesome.money,
      'credito': FontAwesome5.credit_card,
      'debito': FontAwesome5.university,
    };
    final Map<String, Color> colorMap = {
      'dinheiro': Colors.green,
      'credito': Colors.purple,
      'debito': Colors.blue,
    };
    double safeDoubleParse(String? input) {
      if (input == null || input.trim().isEmpty) return 0.0;
      try {
        return double.tryParse(input.trim().replaceAll(',', '.')) ?? 0.0;
      } catch (e) {
        debugPrint('Erro ao converter para double: "$input" => $e');
        return 0.0;
      }
    }

    Widget showCharges(String title, String values) {
      final Map<String, String> chargesMap = {
        'Desconto': currency.format(safeDoubleParse(receipt.discount)),
        'Frete': currency.format(safeDoubleParse(receipt.shipping)),
        'Taxas': currency.format(safeDoubleParse(receipt.tariffs)),
      };
      final Map<String, Icon> chargesIconMap = {
        'Desconto': Icon(
          FontAwesome5.minus_circle,
          color: Colors.red,
          size: 16.0,
        ),
        'Frete': Icon(
          FontAwesome5.shipping_fast,
          color: Colors.pinkAccent,
          size: 16.0,
        ),
        'Taxas': Icon(FontAwesome5.coins, color: Colors.orange, size: 16.0),
      };
      return values.isNotEmpty && values != '0' && values != '0.0'
          ? Padding(
              padding: const EdgeInsets.only(
                left: 22.0,
                right: 8.0,
                bottom: 8.0,
              ),
              child: Row(
                children: [
                  chargesIconMap[title] ??
                      Icon(
                        FontAwesome5.info_circle,
                        size: 16.0,
                        color: Colors.grey,
                      ),
                  const SizedBox(width: 8.0),
                  Text(
                    '$title: ${chargesMap[title]}',
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          : const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Icon(
                FontAwesome5.scroll,
                size: 16.0,
                color: Colors.yellow.shade200,
              ),
              const SizedBox(width: 8.0),
              Expanded(
                child: Text(receipt.id, overflow: TextOverflow.ellipsis),
              ),
              Text(
                currency.format(double.parse(receipt.total)),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.limeAccent,
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
          child: Row(
            children: [
              Icon(FontAwesome.calendar, size: 18.0, color: Colors.deepOrange),
              const SizedBox(width: 8.0),
              Text(date.capitalize(), overflow: TextOverflow.ellipsis),
            ],
          ),
        ),
        ...receipt.payments.map(
          (e) => Padding(
            padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
            child: Row(
              children: [
                Icon(
                  iconMap[e.type] ?? FontAwesome5.qrcode,
                  size: 18.0,
                  color: colorMap[e.type] ?? Colors.teal,
                ),
                const SizedBox(width: 8.0),
                Text(
                  '${e.type.capitalize()}: ${currency.format(safeDoubleParse(e.value))}',
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
        showCharges('Desconto', receipt.discount),
        if (receipt.discountReason.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 22.0, bottom: 8.0),
            child: Text(
              'Razão: ${receipt.discountReason.capitalize()}',
              overflow: TextOverflow.ellipsis,
            ),
          ),
        showCharges('Frete', receipt.shipping),
        showCharges('Taxas', receipt.tariffs),
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
