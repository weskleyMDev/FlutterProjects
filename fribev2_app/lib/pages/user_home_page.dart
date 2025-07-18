import 'package:flutter/material.dart';

import '../models/product.dart';
import '../services/data/local_data_service.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Home Page'),
        actions: [
          IconButton(
            onPressed: () => LocalDataService().save(
              Product(
                id: DateTime.now().toString(),
                name: 'New Product',
                price: '0.00',
                category: 'General',
                type: 'UN',
                stock: '0',
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: LocalDataService().getProducts(),
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
              final products = snapshot.data!;
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
