import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/cart_panel.dart';
import '../../components/drawer_admin.dart';
import '../../components/sales_panel.dart';
import '../../models/product.dart';
import '../../services/receipt_to_pdf.dart';
import '../../stores/cart.store.dart';
import '../../stores/payment.store.dart';
import '../../stores/sales.store.dart';
import '../../stores/stock.store.dart';

const paymentType = ['Dinheiro', 'Debito', 'Credito', 'Pix'];

class SalesHomePage extends StatefulWidget {
  const SalesHomePage({super.key});

  @override
  State<SalesHomePage> createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
  final formKey = GlobalKey<FormState>();
  final ReceiptGenerator _generate = ReceiptGenerator();
  String _phoneNumber = '';

  Future<void> _launchURL(String url, String path) async {
    if (await canLaunchUrl(Uri.https(url, path))) {
      await launchUrl(Uri.https(url, path));
    } else {
      throw 'Não foi possível abrir o link: $url';
    }
  }

  Future<bool?> _showPhoneDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Número de Telefone'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            decoration: const InputDecoration(
              label: Text('Número'),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _phoneNumber = value;
              });
            },
          ),
          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => context.pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  Future<bool?> _showPaymentDialog(BuildContext context) {
    final payStore = Provider.of<PaymentStore>(context, listen: false);
    final cartStore = Provider.of<CartStore>(context, listen: false);
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'Recibo',
          ),
          content: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 8.0),
                  child: DropdownButtonFormField(
                    key: const ValueKey('paymentType'),
                    decoration: InputDecoration(
                      labelText: 'Forma de Pagamento',
                      border: OutlineInputBorder(),
                    ),
                    value: payStore.paymentType.isEmpty
                        ? null
                        : payStore.paymentType,
                    items: paymentType.map((type) {
                      return DropdownMenuItem(value: type, child: Text(type));
                    }).toList(),
                    onChanged: (value) => payStore.setPaymentType(value ?? ''),
                    validator: (value) {
                      final payType = value?.trim() ?? '';
                      if (payType.isEmpty) {
                        return 'Campo obrigatório!';
                      }
                      return null;
                    },
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(bottom: 14.0),
                  child: TextFormField(
                    key: const ValueKey('paymentValue'),
                    decoration: InputDecoration(
                      labelText: 'Valor',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    onChanged: (value) => payStore.setPaymentValue(
                      value.trim().replaceAll(',', '.'),
                    ),
                    validator: (value) {
                      final payValue = value?.trim() ?? '';
                      if (payValue.isEmpty) {
                        return 'Campo obrigatório!';
                      }
                      final valid = RegExp(
                        r'^\d+([.,]\d{0,2})?$',
                      ).hasMatch(payValue);
                      if (!valid) {
                        return 'Digite apenas números (ex: 12.89)';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: () async {
                    final isValid = formKey.currentState?.validate() ?? false;
                    if (!isValid) return;
                    await payStore.pay();
                    formKey.currentState?.reset();
                  },
                  child: const Text('ADICIONAR'),
                ),
                Observer(
                  builder: (_) {
                    return Column(
                      children: [
                        if (payStore.payments.isNotEmpty)
                          const Divider(thickness: 2.0),
                        Container(
                          margin: const EdgeInsets.only(top: 3.0),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: payStore.payments.map((payment) {
                              return Card(
                                margin: const EdgeInsets.only(bottom: 5.0),
                                child: ListTile(
                                  title: Text(
                                    '${payment.type}: R\$ ${double.parse(payment.value).toStringAsFixed(2).replaceAll('.', ',')}',
                                  ),
                                  trailing: IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () =>
                                        payStore.removePayment(payment),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        if (payStore.payments.isNotEmpty)
                          const Divider(thickness: 2.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                      'Pago: R\$ ${payStore.totalPayments.replaceAll('.', ',')}',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                ),
                                Container(
                                  margin: const EdgeInsets.only(top: 8.0),
                                  child: Text(
                                    'Restante: R\$ ${(Decimal.parse(cartStore.totalAmount) - Decimal.parse(payStore.totalPayments)).toDouble().toStringAsFixed(2).replaceAll('.', ',')}',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          ),

          actions: [
            TextButton(
              onPressed: () => context.pop(false),
              child: const Text('Cancelar'),
            ),
            Observer(
              builder: (context) {
                return TextButton(
                  onPressed:
                      (double.parse(cartStore.totalAmount) ==
                          double.parse(payStore.totalPayments))
                      ? () => context.pop(true)
                      : null,
                  child: const Text('Pagar'),
                );
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartStore = Provider.of<CartStore>(context, listen: false);
    final salesStore = Provider.of<SalesStore>(context, listen: false);
    final payStore = Provider.of<PaymentStore>(context, listen: false);
    final stock = Provider.of<StockStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('VENDAS'),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () async {
                final confirm = await _showPhoneDialog(context);
                if (confirm == true) {
                  _launchURL('wa.me', '/55$_phoneNumber');
                }
              },
              icon: Icon(FontAwesomeIcons.whatsapp),
              iconSize: 24.0,
              tooltip: 'Enviar Recibo!',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () {
                cartStore.clear();
                payStore.reset();
              },
              icon: Icon(Icons.refresh_outlined),
              iconSize: 28.0,
              tooltip: 'Limpar Carrinho!',
            ),
          ),
        ],
      ),
      drawer: DrawerAdmin(),
      body: FutureBuilder(
        future: stock.filterList,
        builder: (context, asyncSnapshot) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(child: SalesPanel()),
              const VerticalDivider(width: 1.0, thickness: 2.0),
              Expanded(child: CartPanel()),
            ],
          );
        },
      ),
      floatingActionButton: StreamBuilder(
        stream: stock.productsList,
        builder: (context, asyncSnapshot) {
          return Observer(
            builder: (context) {
              return FloatingActionButton.extended(
                onPressed: cartStore.cartList.isEmpty
                    ? null
                    : () async {
                        final confirmPayment = await _showPaymentDialog(
                          context,
                        );
                        if (confirmPayment == true) {
                          final products = asyncSnapshot.data ?? [];
                          for (var cart in cartStore.cartList.values) {
                            final Product product = products.firstWhere(
                              (p) => p.id == cart.productId,
                            );
                            final quantity = cart.quantity;
                            final newQuantity =
                                (Decimal.parse(product.amount) -
                                        Decimal.parse(quantity))
                                    .toString();
                            stock.updateQuantityById(
                              id: product.id,
                              quantity: newQuantity,
                            );
                          }
                          final receipt = await salesStore.createReceipt(
                            cart: cartStore,
                            payments: payStore.payments,
                          );
                          _generate.generateReceipt(receipt: receipt);
                          cartStore.clear();
                          payStore.reset();
                        }
                      },
                label: Text('FINALIZAR VENDA'),
                extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
                icon: Icon(Icons.point_of_sale_outlined),
                backgroundColor: (cartStore.cartList.isEmpty)
                    ? Colors.grey.withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.primaryContainer,
                foregroundColor: (cartStore.cartList.isEmpty)
                    ? Colors.white.withValues(alpha: 0.2)
                    : Theme.of(context).colorScheme.onSurface,
              );
            },
          );
        },
      ),
    );
  }
}
