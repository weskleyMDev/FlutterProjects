import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../components/cart_panel.dart';
import '../../components/drawer_admin.dart';
import '../../components/sales_panel.dart';
import '../../services/receipt_topdf.dart';
import '../../stores/cart.store.dart';
import '../../stores/sales.store.dart';

class SalesHomePage extends StatefulWidget {
  const SalesHomePage({super.key});

  @override
  State<SalesHomePage> createState() => _SalesHomePageState();
}

class _SalesHomePageState extends State<SalesHomePage> {
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
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: const Text('Confirmar'),
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
        onPressed: () async {
          final receipt = await salesStore.createReceipt(cart: cartStore);
          cartStore.clear();
          _generate.generateReceipt(receipt: receipt);
        },
        label: Text('FINALIZAR VENDA'),
        extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
        icon: Icon(Icons.point_of_sale_outlined),
      ),
    );
  }
}
