import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:go_router/go_router.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({
    super.key,
    required this.cartStore,
    required this.stockStore,
  });

  final CartStore cartStore;
  final StockStore stockStore;

  @override
  State<CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  late final TextEditingController _quantityController;
  late final GlobalKey<FormState> _formCartKey;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _formCartKey = GlobalKey<FormState>();
  }

  @override
  void dispose() {
    _quantityController.dispose();
    super.dispose();
  }

  Future<bool?> _showQuantityDialog(CartItem cartItem) async {
    if (cartItem.product != null) {
      final decimalPlaces = cartItem.product!.measure == 'KG' ? 3 : 0;
      _quantityController.text = cartItem.quantity.toStringAsFixed(
        decimalPlaces,
      );
    }
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(S.of(context).set_quantity),
          content: Form(
            key: _formCartKey,
            child: TextFormField(
              controller: _quantityController,
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
                final measure = cartItem.product?.measure;
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
              onPressed: () => _submitUpdateQuantity(cartItem),
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
    _formCartKey.currentState?.reset();
  }

  void _showSnackMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _submitUpdateQuantity(CartItem cartItem) async {
    final isValid = _formCartKey.currentState?.validate() ?? false;
    if (!isValid) return;
    _formCartKey.currentState?.save();
    final quantity = double.parse(widget.cartStore.quantity);
    final amount = double.parse(cartItem.product!.amount);
    if (quantity > amount) {
      _showSnackMessage(S.of(context).quantity_out);
      return;
    }
    final success = await widget.cartStore.updateQuantity(cartItem.id);
    if (success) {
      if (!mounted) return;
      _clearForm();
      context.pop(true);
    }
  }

  Future<bool> _finalizeSale() async {
    final cartList = widget.cartStore.cartList;
    for (final cartItem in cartList) {
      final product = await widget.stockStore.getProductById(
        id: cartItem.productId,
      );
      if (product == null) continue;

      final newQuantity =
          (Decimal.parse(product.amount) -
                  Decimal.parse(cartItem.quantity.toString()))
              .toDouble();
      await widget.stockStore.updateQuantityById(
        id: product.id,
        quantity: newQuantity.toString(),
      );
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Observer(
      builder: (_) {
        final cartList = widget.cartStore.cartList;
        if (cartList.isEmpty) {
          return Center(child: SelectableText(S.of(context).no_products));
        }
        return ListView(
          children: [
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                final cartItem = cartList[index];
                final decimalPlaces = cartItem.product!.measure == 'KG' ? 3 : 0;
                return Card(
                  child: ListTile(
                    title: Text(
                      '${cartItem.product!.name} - R\$${cartItem.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: InkWell(
                      onTap: () async {
                        await _showQuantityDialog(cartItem);
                      },
                      child: Text(
                        '${S.of(context).quantity}: ${cartItem.quantity.toStringAsFixed(decimalPlaces).replaceAll('.', ',')}',
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    trailing: IconButton(
                      onPressed: () {
                        widget.cartStore.removeProductById(cartItem.id);
                      },
                      icon: Icon(FontAwesome.trash_empty),
                      color: Colors.red,
                      tooltip: S.of(context).remove_product,
                    ),
                  ),
                );
              },
            ),
            const Divider(height: 28.0),
            Card(
              child: ListTile(
                title: Text(
                  'Total: R\$${widget.cartStore.total.toStringAsFixed(2).replaceAll('.', ',')}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
            const Divider(height: 28.0),
            FilledButton(
              onPressed: () async {
                final success = await _finalizeSale();
                if (success) {
                  widget.cartStore.clearCart();
                }
              },
              child: Text('Finalizar Pedido'),
            ),
          ],
        );
      },
    );
  }
}
