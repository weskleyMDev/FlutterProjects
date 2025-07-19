import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/stock_list.dart';

class StockCategoryPage extends StatelessWidget {
  const StockCategoryPage({
    super.key,
    required this.title,
    required this.category,
  });

  final String title;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 12.0),
            child: IconButton(
              onPressed: () => context.push('/stock-form'),
              icon: const Icon(Icons.add_outlined),
              iconSize: 30.0,
              padding: EdgeInsets.zero,
            ),
          ),
        ],
      ),
      body: StockList(category: category),
    );
  }
}
