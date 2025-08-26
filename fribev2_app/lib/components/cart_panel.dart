import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome_icons.dart';
import 'package:fribev2_app/generated/l10n.dart';
import 'package:fribev2_app/models/cart_item.dart';
import 'package:fribev2_app/services/receipt_to_pdf.dart';
import 'package:fribev2_app/stores/cart.store.dart';
import 'package:fribev2_app/stores/payment.store.dart';
import 'package:fribev2_app/stores/sales.store.dart';
import 'package:fribev2_app/stores/stock.store.dart';
import 'package:fribev2_app/utils/dialogs.dart';
import 'package:go_router/go_router.dart';

class CartPanel extends StatefulWidget {
  const CartPanel({
    super.key,
    required this.cartStore,
    required this.stockStore,
    required this.paymentStore,
    required this.salesStore,
  });

  final CartStore cartStore;
  final StockStore stockStore;
  final PaymentStore paymentStore;
  final SalesStore salesStore;

  @override
  State<CartPanel> createState() => _CartPanelState();
}

class _CartPanelState extends State<CartPanel> {
  late final TextEditingController _quantityController;
  late final GlobalKey<FormState> _formCartKey;
  late final GlobalKey<FormState> _formPayKey;

  @override
  void initState() {
    super.initState();
    _quantityController = TextEditingController();
    _formCartKey = GlobalKey<FormState>();
    _formPayKey = GlobalKey<FormState>();
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
              key: const ValueKey('quantity_cart'),
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
    final success = await widget.cartStore.updateQuantity(context, cartItem.id);
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
    final receipt = await widget.salesStore.createReceipt(
      cart: widget.cartStore,
      payments: widget.paymentStore.payments,
    );

    await ReceiptGenerator().generateReceipt(receipt: receipt);
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
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Produtos:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: cartList.length,
                      itemBuilder: (_, index) {
                        final cartItem = cartList[index];
                        final decimalPlaces = cartItem.product!.measure == 'KG'
                            ? 3
                            : 0;
                        return ListTile(
                          title: Text(
                            '${cartItem.product!.name} - R\$${cartItem.subtotal.toStringAsFixed(2).replaceAll('.', ',')}',
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: InkWell(
                            onTap: () async {
                              await _showQuantityDialog(cartItem);
                              widget.paymentStore.clearPayments();
                            },
                            child: Text(
                              '${S.of(context).quantity}: ${cartItem.quantity.toStringAsFixed(decimalPlaces).replaceAll('.', ',')}',
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              widget.cartStore.removeProductById(
                                context,
                                cartItem.id,
                              );
                              widget.paymentStore.clearPayments();
                            },
                            icon: Icon(FontAwesome.trash_empty),
                            color: Colors.red,
                            tooltip: S.of(context).remove_product,
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 28.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Resumo:',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    ListTile(
                      title: Text(
                        'Total: R\$${widget.cartStore.total.toStringAsFixed(2).replaceAll('.', ',')}',
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        'Restante: R\$${widget.cartStore.remaining.toStringAsFixed(2).replaceAll('.', ',')}',
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 28.0),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 12.0),
                      child: Text(
                        'Pagamento(s):',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    Observer(
                      builder: (_) {
                        final payments = widget.paymentStore.payments;
                        final finishSale =
                            widget.paymentStore.totalPayments ==
                            widget.cartStore.total;
                        return Column(
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: payments.length,
                              itemBuilder: (_, index) {
                                final payment = payments[index];
                                return ListTile(
                                  title: Text(
                                    '${payment.type}: R\$${payment.value.replaceAll('.', ',')}',
                                  ),
                                );
                              },
                            ),
                            Center(
                              child: FilledButton(
                                onPressed: finishSale
                                    ? null
                                    : () {
                                        paymentMethod(
                                          context,
                                          widget.paymentStore,
                                          widget.cartStore,
                                          _formPayKey,
                                        );
                                      },
                                child: Text(S.of(context).add_payment),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const Divider(height: 28.0),
            Observer(
              builder: (_) {
                final finalize =
                    widget.paymentStore.totalPayments == widget.cartStore.total;
                return FilledButton(
                  onPressed: finalize
                      ? () async {
                          final success = await _finalizeSale();
                          if (success) {
                            widget.cartStore.clearCartStore();
                            widget.paymentStore.clearPaymentStore();
                            if (!context.mounted) return;
                            context.pop();
                          }
                        }
                      : null,
                  child: Text('Finalizar Pedido'),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
