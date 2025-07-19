import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
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
  void initState() {
    super.initState();
    Provider.of<StockStore>(
      context,
      listen: false,
    ).setCategory(widget.category);
  }

  @override
  void dispose() {
    stockStore.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    return Observer(
      builder: (context) => Column(
        children: [
          StockSearch(onChange: (value) => stockStore.searchQuery = value),
          const SizedBox(height: 12),
          stockStore.productList.isEmpty
              ? Expanded(
                  child: const Center(
                    child: Text('Nenhum produto encontrado.'),
                  ),
                )
              : Expanded(
                  child: ListView.builder(
                    itemCount: stockStore.productList.length,
                    itemBuilder: (context, index) {
                      final product = stockStore.productList[index];
                      return Container(
                        margin: const EdgeInsets.symmetric(
                          vertical: 5.0,
                          horizontal: 16.0,
                        ),
                        child: Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.35,
                            motion: BehindMotion(),
                            children: [
                              SlidableAction(
                                onPressed: null,
                                icon: Icons.edit_outlined,
                                backgroundColor: Colors.blue,
                                padding: EdgeInsets.zero,
                                label: 'Atualizar',
                              ),
                              SlidableAction(
                                onPressed: null,
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
                  ),
                ),
        ],
      ),
    );
  }
}
