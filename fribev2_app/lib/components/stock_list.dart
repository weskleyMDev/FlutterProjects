import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../models/product.dart';
import '../stores/stock.store.dart';

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
    return Observer(
      builder: (_) {
        return StreamBuilder<List<Product>>(
          stream: stockStore.products,
          builder: (context, snapshot) {
            final allProducts = snapshot.data ?? [];

            final filteredProducts = allProducts.where((p) {
              final query = _searchController.text.toLowerCase();
              final categoryMatch = p.category.toUpperCase() == widget.category;
              final nameMatch = p.name.toLowerCase().contains(query);
              return categoryMatch && nameMatch;
            }).toList();

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Erro: ${snapshot.error}'));
            }

            if (filteredProducts.isEmpty) {
              return const Center(child: Text('Nenhum produto encontrado.'));
            }

            return CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: TextField(
                      controller: _searchController,
                      decoration: const InputDecoration(
                        labelText: 'Buscar',
                        border: OutlineInputBorder(),
                        suffixIcon: Icon(Icons.search_outlined),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final product = filteredProducts[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text('Price: ${product.price}'),
                    );
                  }, childCount: filteredProducts.length),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
