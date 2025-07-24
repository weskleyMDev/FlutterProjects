import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../stores/stock.store.dart';
import 'stock_search.dart';

class StockList extends StatefulWidget {
  const StockList({super.key, required this.category});

  final String category;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  late StockStore stockStore;
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    stockStore = Provider.of<StockStore>(context, listen: false);

    if (!_initialized) {
      stockStore.setCategory(widget.category);
      _initialized = true;
    }
  }

  @override
  void dispose() {
    stockStore.reset();
    super.dispose();
  }

  Future<bool?> _showConfirmDialog(BuildContext context) {
    return showDialog<bool>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text('Confirmação'),
          content: const Text(
            'Você tem certeza que deseja remover este produto?',
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

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    return Observer(
      builder: (_) => Column(
        children: [
          StockSearch(onChange: (value) => stockStore.searchQuery = value),
          const SizedBox(height: 12),
          Expanded(
            child: FutureBuilder(
              future: stockStore.filterList,
              builder: (_, asyncSnapshot) {
                return StreamBuilder(
                  stream: stockStore.productsList,
                  builder: (_, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.none:
                      case ConnectionState.waiting:
                        return const Center(child: CircularProgressIndicator());
                      default:
                        final products = snapshot.data ?? [];
                        return products.isEmpty
                            ? const Center(
                                child: Text('Nenhum produto encontrado!'),
                              )
                            : ListView.builder(
                                itemCount: products.length,
                                itemBuilder: (_, index) {
                                  final product = products[index];
                                  return Container(
                                    margin: const EdgeInsets.symmetric(
                                      vertical: 5.0,
                                      horizontal: 16.0,
                                    ),
                                    child: Slidable(
                                      endActionPane: ActionPane(
                                        extentRatio: 0.3,
                                        motion: BehindMotion(),
                                        children: [
                                          SlidableAction(
                                            onPressed: (_) {
                                              context.pushNamed(
                                                'stock-edit-form',
                                                extra: product,
                                              );
                                            },
                                            icon: Icons.edit_outlined,
                                            backgroundColor: Colors.blue,
                                            padding: EdgeInsets.zero,
                                            label: 'Atualizar',
                                          ),
                                          SlidableAction(
                                            onPressed: (_) async {
                                              final confirm =
                                                  await _showConfirmDialog(
                                                    context,
                                                  );
                                              if (confirm == true) {
                                                stockStore.removeProductById(
                                                  product: product,
                                                );
                                              }
                                            },
                                            icon: Icons.delete_outline,
                                            backgroundColor: Colors.red,
                                            padding: EdgeInsets.zero,
                                            label: 'Deletar',
                                          ),
                                        ],
                                      ),
                                      child: Card(
                                        shape: RoundedRectangleBorder(),
                                        margin: EdgeInsets.zero,
                                        child: ListTile(
                                          title: Text(
                                            product.name,
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            maxLines: 1,
                                          ),
                                          subtitle: Text(
                                            'Estoque: ${product.amount.replaceAll('.', ',')} (${product.measure}) | Preço: R\$ ${product.price.replaceAll('.', ',')}',
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              );
                    }
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
