import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/stock_list.dart';

class StockBovinePage extends StatelessWidget {
  const StockBovinePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BOVINOS'),
        actions: [
          IconButton(
            onPressed: () => context.push('/stock-form'),
            icon: const Icon(Icons.add_outlined),
          ),
        ],
      ),
      body: const StockList(category: 'BOVINO'),
    );
  }
}
