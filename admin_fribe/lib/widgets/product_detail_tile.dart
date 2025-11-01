import 'package:admin_fribe/models/product_model.dart';
import 'package:admin_fribe/widgets/update_amount_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ProductDetailTile extends StatelessWidget {
  const ProductDetailTile({
    super.key,
    required this.product,
    required this.currencyFormat,
    required this.numberFormat,
  });

  final ProductModel product;
  final NumberFormat currencyFormat;
  final NumberFormat numberFormat;

  @override
  Widget build(BuildContext context) {
    void showEditAmountDialog() {
      showDialog(
        context: context,
        barrierDismissible: false,
        useRootNavigator: true,
        builder: (dialogContext) =>
            UpdateAmountDialog(product: product, dialogContext: dialogContext),
      );
    }

    return InkWell(
      onTap: () => context.pushNamed('edit-product', extra: product),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                  ),
                ),
                Text(
                  currencyFormat.format(double.tryParse(product.price) ?? 0),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.lightGreen,
                  ),
                ),
              ],
            ),
            Text(
              'ID: ${product.id}',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Stock: ${numberFormat.format(double.tryParse(product.amount) ?? 0)}(${product.measure})',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: 30,
                  height: 30,
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: showEditAmountDialog,
                    icon: Icon(
                      FontAwesome.plus,
                      size: 16.0,
                      color: Colors.white70,
                    ),
                    tooltip: 'Edit Product Amount',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
