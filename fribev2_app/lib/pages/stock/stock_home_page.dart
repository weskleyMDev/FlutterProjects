import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../components/drawer_admin.dart';

class StockHomePage extends StatefulWidget {
  const StockHomePage({super.key});

  @override
  State<StockHomePage> createState() => _StockHomePageState();
}

class _StockHomePageState extends State<StockHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ESTOQUE')),
      drawer: DrawerAdmin(),
      body: Center(
        child: Column(
          children: [
            ElevatedButton(
              onPressed: () => context.pushNamed(
                'stock-category',
                pathParameters: {'title': 'BOVINO', 'category': 'BOVINO'},
              ),
              child: const Text('Bovinos'),
            ),
            ElevatedButton(
              onPressed: () => context.pushNamed(
                'stock-category',
                pathParameters: {'title': 'AVES', 'category': 'AVES'},
              ),
              child: const Text('Aves'),
            ),
          ],
        ),
      ),
    );
  }
}
