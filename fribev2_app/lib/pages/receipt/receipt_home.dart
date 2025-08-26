import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/models/sales_receipt.dart';
import 'package:fribev2_app/utils/capitalize_text.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:mobx/mobx.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../stores/sales.store.dart';
import '../../stores/sales_filter.store.dart';

class ReceiptHomePage extends StatefulWidget {
  const ReceiptHomePage({super.key});

  @override
  State<ReceiptHomePage> createState() => _ReceiptHomePageState();
}

class _ReceiptHomePageState extends State<ReceiptHomePage> {
  late final SalesStore _salesStore;
  late final SalesFilterStore _salesFilterStore;
  late ReactionDisposer _receiptDisposer;
  late ReactionDisposer _productDisposer;

  @override
  void initState() {
    super.initState();
    _salesStore = context.read<SalesStore>()..fetchReceipts();
    _salesFilterStore = context.read<SalesFilterStore>();
    _receiptDisposer = autorun((_) {
      final receipts = _salesStore.receipts;
      _salesFilterStore.setGroupedSales(receipts);
    });
    _productDisposer = reaction<List<SalesReceipt>>(
      (_) => _salesStore.receipts,
      (receipts) {
        for (var receipt in receipts) {
          if (!_salesStore.receiptProducts.containsKey(receipt.id)) {
            _salesStore.fetchProductForReceipt(
              context,
              receipt.cart,
              receipt.id,
            );
          }
        }
      },
    );
  }

  @override
  void dispose() {
    _receiptDisposer();
    _productDisposer();
    super.dispose();
  }

  String _clientData = '';
  bool _isEmail = false;

  Future<void> _launchPhoneURL(String url, String path) async {
    if (await canLaunchUrl(Uri.https(url, path))) {
      await launchUrl(Uri.https(url, path));
    } else {
      throw 'Não foi possível abrir o link: $url$path';
    }
  }

  Future<void> _launchEmailURL(
    String url,
    String path,
    Map<String, String> query,
  ) async {
    if (await canLaunchUrl(Uri.https(url, path, query))) {
      await launchUrl(Uri.https(url, path, query));
    } else {
      throw 'Não foi possível abrir o link: $url$path';
    }
  }

  Future<bool?> _showPhoneDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: Text(_isEmail ? 'Email' : 'Número de Telefone'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              label: Text(_isEmail ? 'Email' : 'Número'),
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              setState(() {
                _clientData = value;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recibos'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() => _isEmail = false);
              final confirm = await _showPhoneDialog(context);
              if (confirm == true) {
                _launchPhoneURL('wa.me', '/+55$_clientData');
              }
            },
            icon: Icon(FontAwesome5.whatsapp),
            iconSize: 24.0,
            tooltip: 'Enviar Recibo por WhatsApp!',
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () async {
                setState(() => _isEmail = true);
                final confirm = await _showPhoneDialog(context);
                if (confirm == true) {
                  _launchEmailURL('mail.google.com', '/mail', {
                    'view': 'cm',
                    'fs': '1',
                    'to': _clientData,
                    'su': 'Recibo de Compra',
                    'body':
                        'Ola, segue em anexo o recibo da sua compra. Fribe agradece sua preferencia!',
                  });
                }
              },
              icon: const Icon(Icons.email_outlined),
              iconSize: 28.0,
              tooltip: 'Enviar Recibo por Email!',
            ),
          ),
        ],
      ),
      body: Observer(
        builder: (_) {
          final locale = Localizations.localeOf(context).languageCode;
          final currency = NumberFormat.simpleCurrency(locale: locale);
          final measure = NumberFormat.compact(locale: locale);
          final status = _salesStore.receiptStreamStatus;
          if (status == StreamStatus.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final receipts = _salesStore.receipts;
          if (receipts.isEmpty) {
            return const Center(child: Text('Nenhum recibo encontrado.'));
          }
          return ListView.builder(
            itemCount: _salesFilterStore.sortedKeys.length,
            itemBuilder: (_, index) {
              final dateKey = _salesFilterStore.sortedKeys[index];
              final salesDay = _salesFilterStore.groupedSales[dateKey] ?? [];
              final totalDay = salesDay
                  .fold<Decimal>(
                    Decimal.zero,
                    (sum, doc) => sum + Decimal.parse(doc.total),
                  )
                  .round(scale: 2)
                  .toStringAsFixed(2);
              return ExpansionTile(
                title: Text(
                  '$dateKey - ${currency.format(double.parse(totalDay))}',
                  overflow: TextOverflow.ellipsis,
                ),
                children: [
                  ...salesDay.map((sales) {
                    final date = DateFormat.yMMMMEEEEd(
                      locale,
                    ).add_Hm().format(sales.createAt);
                    return Column(
                      children: [
                        const Divider(),
                        ListTile(
                          title: SelectableText('Recibo: ${sales.id}'),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                date.capitalize(),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                'Total: ${currency.format(double.parse(sales.total))}',
                                overflow: TextOverflow.ellipsis,
                              ),
                              Observer(
                                builder: (_) {
                                  final cartProducts =
                                      _salesStore.receiptProducts[sales.id] ??
                                      [];
                                  if (cartProducts.isEmpty) {
                                    return const SizedBox.shrink();
                                  }
                                  return ListView.separated(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: cartProducts.length,
                                    separatorBuilder: (_, _) => const Divider(
                                      height: 1,
                                      thickness: 0.5,
                                    ),
                                    itemBuilder: (_, i) {
                                      final cartProduct = cartProducts[i];
                                      final productName = cartProduct
                                          .product
                                          .name
                                          .capitalize();
                                      final productQuantity = measure.format(
                                        cartProduct.quantity,
                                      );
                                      final productSubtotal = currency.format(
                                        cartProduct.subtotal,
                                      );
                                      return ListTile(
                                        title: Text(
                                          '$productName x$productQuantity',
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        subtitle: Text(
                                          productSubtotal,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
