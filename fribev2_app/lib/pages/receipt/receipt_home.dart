import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
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
  String _clientData = '';
  bool isEmail = false;

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
          title: Text(isEmail ? 'Email' : 'Número de Telefone'),
          content: TextField(
            autofocus: true,
            keyboardType: TextInputType.phone,
            decoration: InputDecoration(
              label: Text(isEmail ? 'Email' : 'Número'),
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
    final salesStore = Provider.of<SalesStore>(context, listen: false);
    final salesFilterStore = Provider.of<SalesFilterStore>(
      context,
      listen: false,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Recibos'),
        actions: [
          IconButton(
            onPressed: () async {
              setState(() => isEmail = false);
              final confirm = await _showPhoneDialog(context);
              if (confirm == true) {
                _launchPhoneURL('wa.me', '/55$_clientData');
              }
            },
            icon: Icon(FontAwesomeIcons.whatsapp),
            iconSize: 24.0,
            tooltip: 'Enviar Recibo por WhatsApp!',
          ),
          Container(
            margin: const EdgeInsets.only(right: 10.0),
            child: IconButton(
              onPressed: () async {
                setState(() => isEmail = true);
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
      body: FutureBuilder(
        future: salesStore.fetchReceipts(),
        builder: (context, asyncSnapshot) {
          return StreamBuilder(
            stream: salesStore.allReceipts,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.none:
                case ConnectionState.waiting:
                  return const Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return const Center(child: Text('Erro ao buscar dados.'));
                  } else {
                    final receipts = snapshot.data ?? [];
                    if (receipts.isEmpty) {
                      return const Center(
                        child: Text('Nenhum recibo encontrado.'),
                      );
                    }
                    salesFilterStore.setGroupedSales(receipts);
                    return ListView.builder(
                      itemCount: salesFilterStore.sortedKeys.length,
                      itemBuilder: (context, index) {
                        final dateKey = salesFilterStore.sortedKeys[index];
                        final salesDay =
                            salesFilterStore.groupedSales[dateKey] ?? [];
                        salesFilterStore.setTotalOfDay(salesDay);
                        final totalDay = salesFilterStore.totalOfDay;
                        return ExpansionTile(
                          title: Text(
                            '$dateKey - R\$ ${totalDay.replaceAll('.', ',')}',
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              itemCount: salesDay.length,
                              itemBuilder: (context, index) {
                                final sales = salesDay[index];
                                return ListTile(
                                  title: SelectableText('Recibo: #${sales.id}'),
                                  subtitle: Text(
                                    'Total: R\$ ${sales.total.replaceAll('.', ',')}',
                                  ),
                                );
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
              }
            },
          );
        },
      ),
    );
  }
}
