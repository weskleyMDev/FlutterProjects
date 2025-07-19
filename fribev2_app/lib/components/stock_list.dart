import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../stores/stock.store.dart';
import 'stock_search.dart';

class StockList extends StatefulWidget {
  const StockList({super.key, required this.category});

  final String category;

  @override
  State<StockList> createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _searchController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    return Column(
      children: [
        StockSearch(controller: _searchController),
        Expanded(
          child: Observer(
            builder: (_) {
              return StreamBuilder<List<Product>>(
                stream: stockStore.products,
                builder: (context, snapshot) {
                  final allProducts = snapshot.data ?? [];
              
                  final filteredProducts = allProducts.where((p) {
                    final query = _searchController.text.toLowerCase();
                    final categoryMatch =
                        p.category.toUpperCase() == widget.category;
                    final nameMatch = p.name.toLowerCase().contains(
                      query,
                    );
                    return categoryMatch && nameMatch;
                  }).toList();
              
                  if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
              
                  if (snapshot.hasError) {
                    return Center(child: Text('Erro: ${snapshot.error}'));
                  }
              
                  if (filteredProducts.isEmpty) {
                    return const Center(
                      child: Text('Nenhum produto encontrado.'),
                    );
                  }
              
                  return ListView.builder(
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      final product = filteredProducts[index];
                      return Container(
                        margin: const EdgeInsets.only(bottom: 10.0, left: 10.0, right: 10.0),
                        child: Slidable(
                          endActionPane: ActionPane(
                            extentRatio: 0.30,
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
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
