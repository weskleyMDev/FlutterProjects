import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../stores/stock.store.dart';

class StockBovinePage extends StatelessWidget {
  const StockBovinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final stockStore = Provider.of<StockStore>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('BOVINOS')),
      body: StreamBuilder<List<Product>>(
        stream: stockStore.stock,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No products available.'));
              }
              final products = snapshot.data!
                  .where((p) => p.category == 'BOVINO')
                  .toList();
              return ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  final product = products[index];
                  return ListTile(
                    title: Text(product.name),
                    subtitle: Text('Price: ${product.price}'),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
