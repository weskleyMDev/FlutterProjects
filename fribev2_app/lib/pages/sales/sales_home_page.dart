import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/cart_panel.dart';
import '../../components/drawer_admin.dart';
import '../../components/sales_panel.dart';
import '../../services/receipt_topdf.dart';
import '../../stores/cart.store.dart';
import '../../stores/payment.store.dart';
import '../../stores/sales.store.dart';

const paymentType = ['Dinheiro', 'Debito', 'Credito', 'Pix'];

class SalesHomePage extends StatefulWidget {
  const SalesHomePage({super.key});

  @override
  State<SalesHomePage> createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
  final formKey = GlobalKey<FormState>();
  final ReciboGenerator _generate = ReciboGenerator();
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
      builder: (context) {
        return AlertDialog(
          scrollable: true,
          title: Text(
            'À pagar: R\$ ${cartStore.totalAmount.replaceAll('.', ',')}',
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
                const Divider(thickness: 2.0),
                Observer(
                  builder: (_) {
                    return Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(top: 8.0),
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
                        const Divider(thickness: 2.0),
                        Chip(
                          label: Text(
                            'Pago: R\$ ${payStore.totalPayments.replaceAll('.', ',')}',
                            style: TextStyle(fontSize: 16.0),
                          ),
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
                      ? () => context.pop(false)
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
              },
              icon: Icon(Icons.refresh_outlined),
              iconSize: 28.0,
              tooltip: 'Limpar Carrinho!',
            ),
          ),
        ],
      ),
      drawer: DrawerAdmin(),
      body: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(child: SalesPanel()),
          const VerticalDivider(width: 1.0, thickness: 2.0),
          Expanded(child: CartPanel()),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          _showPaymentDialog(context);
          // final receipt = await salesStore.createReceipt(cart: cartStore);
          // cartStore.clear();
          // _generate.generateReceipt(receipt: receipt);
        },
        label: Text('FINALIZAR VENDA'),
        extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
        icon: Icon(Icons.point_of_sale_outlined),
      ),
    );
  }
}
