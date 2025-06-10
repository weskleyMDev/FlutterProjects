import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/components/home_drawer.dart';

import '../components/product_edit.dart';
import '../models/product_list.dart';
import '../utils/app_routes.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  Future<void> _refreshProducts(BuildContext context) async {
    try {
      await Provider.of<ProductList>(context, listen: false).loadProducts();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    final products = Provider.of<ProductList>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Produtos"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productForm);
            },
            icon: Icon(Icons.add_sharp),
          ),
        ],
      ),
      drawer: HomeDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: ListView.builder(
          itemCount: products.items.length,
          itemBuilder: (ctx, index) =>
              ProductEdit(product: products.items[index]),
        ),
      ),
    );
  }
}
