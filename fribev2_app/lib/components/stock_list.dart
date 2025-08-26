import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/loading_screen.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/models/product.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:go_router/go_router.dart';
import 'package:mobx/mobx.dart';

import '../stores/stock.store.dart';

class StockList extends StatefulWidget {
  const StockList({
    super.key,
    required this.stockStore,
    required this.cartStore,
  });

  final StockStore stockStore;
  final CartStore cartStore;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late final TextEditingController _quantityController;
  late final GlobalKey<FormState> _formStockKey;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _formStockKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<bool?> _showQuantityDialog(Product product) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).set_quantity),
          content: Form(
            key: _formStockKey,
            child: TextFormField(
              key: const ValueKey('quantity_sale'),
              controller: _quantityController,
              autofocus: true,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(
                labelText: S.of(context).quantity,
                border: OutlineInputBorder(),
              ),
              onSaved: (text) => widget.cartStore.quantity = (text ?? '')
                  .trim()
                  .replaceAll(',', '.'),
              validator: (value) {
                final text = value?.trim().replaceAll(',', '.') ?? '';
                if (text.isEmpty) {
                  return S.of(context).required_field;
                }
                final measure = product.measure;
                final decimalValid = RegExp(
                  r'^(?!0+(?:[.,]0{0,3})?$)(?:[1-9]\d*|0[.,]\d{1,3}|[1-9]\d*[.,]\d{1,3})$',
                ).hasMatch(text);
                if (measure == 'KG' && !decimalValid) {
                  return S.of(context).decimal_valid;
                }
                final intValid = RegExp(r'^[1-9]\d{0,9}$').hasMatch(text);
                if (measure != 'KG' && !intValid) {
                  return S.of(context).integer_valid;
                }
                return null;
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.pop(false);
                _clearForm();
              },
              child: Text(S.of(context).cancel),
            ),
            TextButton(
              onPressed: () => _submitQuantity(product),
              child: Text(S.of(context).confirm),
            ),
          ],
        );
      },
    );
  }

  void _clearForm() {
    widget.cartStore.quantity = '0';
    _quantityController.clear();
    _formStockKey.currentState?.reset();
  }

  void _showSnackMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitQuantity(Product product) async {
    final isValid = _formStockKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formStockKey.currentState?.save();
    final quantity = double.parse(widget.cartStore.quantity);
    final amount = double.parse(product.amount);
    if (quantity > amount) {
      _showSnackMessage(S.of(context).quantity_out);
      return;
    }
    final success = widget.cartStore.addProduct(context, product);
    if (success) {
      if (!mounted) return;
      _showSnackMessage(S.of(context).product_added);
      _clearForm();
      context.pop(true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final status = widget.stockStore.productStreamStatus;
        if (status == StreamStatus.waiting) {
          return const LoadingScreen();
        }
        final products = widget.stockStore.filteredProducts;
        if (products.isEmpty) {
          return Center(child: Text(S.of(context).no_products));
        } else {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: products.length,
              itemBuilder: (_, index) {
                final product = products[index];
                return Card(
                  child: ListTile(
                    key: ValueKey(product.id),
                    title: Text(product.name, overflow: TextOverflow.ellipsis),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${S.of(context).price}: R\$${product.price.replaceAll('.', ',')}',
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${S.of(context).stock}: ${double.parse(product.amount).toStringAsFixed(3).replaceAll('.', ',')} (${product.measure})',
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    trailing: Observer(
                      builder: (_) {
                        final inCart = widget.cartStore.isProductInCart(
                          product,
                        );
                        return IconButton(
                          onPressed: inCart
                              ? null
                              : () async {
                                  await _showQuantityDialog(product);
                                },
                          icon: Icon(FontAwesome5.shopping_basket),
                          color: Colors.green,
                          tooltip: inCart
                              ? S.of(context).already_in_cart
                              : S.of(context).add_cart,
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
