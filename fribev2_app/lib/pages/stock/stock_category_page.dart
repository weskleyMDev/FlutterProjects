import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';
import 'package:fribev2_app/components/category_list.dart';
import 'package:fribev2_app/components/search_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../stores/stock.store.dart';

class StockCategoryPage extends StatefulWidget {
  const StockCategoryPage({
    super.key,
    required this.title,
    required this.category,
  });

  final String title;
  final String category;

  @override
  State<StockCategoryPage> createState() => _StockCategoryPageState();
}

class _StockCategoryPageState extends State<StockCategoryPage> {
  late final StockStore _stockStore;
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _stockStore = context.read<StockStore>()
      ..fetchData(category: widget.category);
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _stockStore.disposeStock();
    super.dispose();
  }

  // Future<bool?> _showConfirmDialog(BuildContext context) {
  //   return showDialog<bool>(
  //     context: context,
  //     barrierDismissible: false,
  //     builder: (context) {
  //       return AlertDialog(
  //         title: const Text('Confirmação'),
  //         content: const Text(
  //           'Você tem certeza que deseja remover todos os produtos desta categoria?',
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(false),
  //             child: const Text('Cancelar'),
  //           ),
  //           TextButton(
  //             onPressed: () => Navigator.of(context).pop(true),
  //             child: const Text('Confirmar'),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          if (Platform.isWindows)
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              child: IconButton(
                onPressed: _openSysCalculator,
                icon: const Icon(FontAwesome5.calculator),
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
      body: CategoryList(stockStore: _stockStore),
      bottomNavigationBar: CustomSearchBar(
        searchController: _searchController,
        stockStore: _stockStore,
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () async {
      //     final confirm = await _showConfirmDialog(context);
      //     if (confirm == true) {
      //       stockStore.removeAllByCategory(category: widget.category);
      //     }
      //   },
      //   label: Text('REMOVER TUDO'),
      //   icon: Icon(Icons.delete_forever_outlined),
      //   extendedPadding: EdgeInsets.symmetric(horizontal: 12.0),
      // ),
    );
  }
}
