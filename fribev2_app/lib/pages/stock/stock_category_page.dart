import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../components/stock_list.dart';
import '../../stores/stock.store.dart';

class StockCategoryPage extends StatelessWidget {
  const StockCategoryPage({
    super.key,
    required this.title,
    required this.category,
  });

  final String title;
  final String category;

  Future<bool?> _showConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text(
            'Você tem certeza que deseja remover todos os produtos desta categoria?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('Confirmar'),
            ),
          ],
        );
      },
    );
  }

  void _openSysCalculator() {
    if (Platform.isWindows) {
      Process.start('calc.exe', []);
    } else if (Platform.isAndroid) {
      return;
    } else {
      throw UnsupportedError('Calculadora não foi encontrada no sistema!');
    }
  }

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          if (Platform.isWindows) Container(
            margin: const EdgeInsets.only(right: 4.0),
            child: IconButton(
              onPressed: _openSysCalculator,
              icon: const Icon(FontAwesomeIcons.calculator),
              iconSize: 24.0,
              padding: EdgeInsets.zero,
              tooltip: 'Abrir Calculadora',
            ),
          ),
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () => context.push('/stock-form/add'),
              icon: const Icon(Icons.add_outlined),
              iconSize: 30.0,
              padding: EdgeInsets.zero,
              tooltip: 'Adicionar Produto',
            ),
          ),
        ],
      ),
      body: StockList(category: category),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final confirm = await _showConfirmDialog(context);
          if (confirm == true) {
            stockStore.removeAllByCategory(category: category);
          }
        },
        label: Text('REMOVER TUDO'),
        icon: Icon(Icons.delete_forever_outlined),
        extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
      ),
    );
  }
}
