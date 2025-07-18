import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/form_data/stock_form_data.dart';
import '../models/product.dart';
import '../services/data/firebase_product_service.dart';
import '../stores/auth.store.dart';

class UserHomePage extends StatelessWidget {
  const UserHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authStore = Provider.of<AuthStore>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(authStore.currentUser?.email ?? 'User Home'),
        actions: [
          IconButton(
            onPressed: authStore.logout,
            icon: Icon(Icons.exit_to_app_sharp),
          ),
          IconButton(
            onPressed: () => FirebaseDataService().save(
              product: StockFormData(
                name: 'New Product',
                category: 'Category',
                measure: 'kg',
                amount: '1',
                price: '10.00',
              ),
            ),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: StreamBuilder<List<Product>>(
        stream: FirebaseDataService().getProducts(),
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
